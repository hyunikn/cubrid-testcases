/*
Test Case: delete & update 
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/not_null/basic_sql/delete_update_05.ctl
Author: Ray

Test Plan: 
Test concurrent DELETE/UPDATE transactions in MVCC (with NOT NULL constraint)

Test Scenario:
C1 delete, C2 update, the affected rows are overlapped (based on where clause)
C1 delete instances intersect with C2 update instances
C2 try to update an unique index to which C1 is trying to delete 
C1,C2's where clauses are not on index (heap scan) 
C1 commit, C2 commit
Metrics: data size = small, index = single index(unique), where clause = no, schema = single table

Test Point:
1) C2 needs to wait until C1 completed (Locking Test)
2) C1 instances will be deleted
   C2 instances will be updated since duplicate key has been deleted  (Visibility/Reevaluation Test)

NUM_CLIENTS = 3
C1: delete from table t1;   
C2: update table t1;  
C3: select on table t1; C3 is used to check the updated result
*/

MC: setup NUM_CLIENTS = 3;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

C3: set transaction lock timeout INFINITE;
C3: set transaction isolation level read committed;

/* preparation */
C1: DROP TABLE IF EXISTS t1;
C1: CREATE TABLE t1(id INT NOT NULL UNIQUE, col VARCHAR(10) NOT NULL, tag VARCHAR(2));
C1: CREATE UNIQUE INDEX idx_id on t1(id);
C1: INSERT INTO t1 VALUES(1,'abc','A'),(2,'def','B'),(3,'ghi','C'),(4,'jkl','D'),(5,'mno','E'),(6,'pqr','F'),(7,'abc','G');
C1: COMMIT WORK;
MC: wait until C1 ready;

/* test case */
C1: DELETE FROM t1 WHERE col IN ('abc','ghi');
MC: wait until C1 ready;
C2: UPDATE t1 SET id = 1, col = 'xyz' WHERE tag IN ('C','F');
/* expect: C2 needs to wait once C1 completed */
MC: wait until C2 blocked;
/* expect: C1 select - id = 1,3,7 are deleted */
C1: SELECT * FROM t1 order by 1,2;
C1: commit;
/* expect: 1 row updated message should generated once C2 ready, C2 select - id = 6 is updated */
MC: wait until C2 ready;
C2: SELECT * FROM t1 order by 1,2;
C2: commit;
MC: wait until C2 ready;
/* expect: id = 1,3,7 are deleted, id = 6 is updated */
C3: select * from t1 order by 1,2;

C1: quit;
C2: quit;
C3: quit;
