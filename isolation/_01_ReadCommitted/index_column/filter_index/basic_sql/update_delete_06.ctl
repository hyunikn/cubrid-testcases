/*
Test Case: update & delete 
Priority: 1
Reference case:
Author: Ray

Test Plan: 
Test UPDATE/DELETE locks (X_LOCK on instance) if the instances of the transactions are overlapped (with filtered index)
C1 updates a index column which will break the filtered index 

Test Scenario:
C1 update, C2 delete, the affected rows are overlapped (based on where clause)
C1's update does not affect the C2's delete
C1 updates a index column
C1,C2 where clause uses filtered index (i.e. index scan - totally)
All C1, C2 instances are using index scan
C1 commit, C2 commit
Metrics: data size = small, index = multiple filtered index(Unique + simple), where clause = simple, schema = single table

Test Point:
1) C2 needs to wait until C1 completed  
2) C1 instances should be updated, C2 instances should be deleted after reevaluation

NUM_CLIENTS = 3
C1: update table t1;  
C2: delete from table t1;  
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
C1: CREATE TABLE t1(id INT, col VARCHAR(10), tag VARCHAR(2));
C1: INSERT INTO t1 VALUES(1,'abc','A'),(2,'def','B'),(3,'ghi','C'),(4,'jkl','D'),(5,'mno','E'),(6,'pqr','F'),(7,'abc','G');
C1: CREATE INDEX idx_id on t1(id) WHERE id >= 2 and id <= 5;
C1: CREATE INDEX idx_col on t1(col) WHERE col = 'def';
C1: COMMIT WORK;
MC: wait until C1 ready;

/* test case */
C1: UPDATE t1 SET tag = 'X' WHERE id IN (2,4,5) USING INDEX idx_id(+);
MC: wait until C1 ready;
C2: DELETE FROM t1 WHERE col = 'def' USING INDEX idx_col(+);
/* expect: C2 needs to wait once C1 completed */
MC: wait until C2 blocked;
/* expect: C1 select - id = 2,4,5 are updated */
C1: SELECT * FROM t1 order by 1,2;
C1: commit;
/* expect: 1 rows (id=2)deleted message, C2 select - id = 2 is deleted */
MC: wait until C2 ready;
C2: SELECT * FROM t1 order by 1,2;
C2: commit;
/* expect: the instances of id = 2 is deleted, id = 4,5 are updated */
C3: select * from t1 order by 1,2;

C1: quit;
C2: quit;
C3: quit;
