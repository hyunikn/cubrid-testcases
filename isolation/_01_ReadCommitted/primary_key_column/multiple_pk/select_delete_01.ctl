/*
Test Case: delete & select
Priority: 1
Reference case:
Author: Lily

Test Point:
changes committed after the query started are never seen

NUM_CLIENTS = 2
C1: DELETE FROM tb1;
C2: select three times - before C1 commit, after C1 commit, after C2 commit. 
*/

MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;
C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

/* preparation */
C1: DROP TABLE IF EXISTS tb1;
C1: CREATE TABLE tb1(id INT,col VARCHAR(10),PRIMARY KEY (id,col));
C1: INSERT INTO tb1 VALUES(1,'abc'),(1,'efd'),(2,'xyz'),(2,'tea'),(2,'web'),(2,'two'),(3,'fun'),(3,'sun');
C1: commit work;

MC: wait until C1 ready;

/* test case */
C2: SELECT *,sleep(1) FROM tb1 WHERE id>0 AND col NOT LIKE 't%';
MC: sleep 1;
C1: DELETE FROM tb1 WHERE id=2;
C1: commit;
MC: wait until C1 ready;
MC: wait until C2 ready;
C2: SELECT * FROM tb1 WHERE id>0;
C1: SELECT * FROM tb1 WHERE id>0;
C1: commit work;
C2: commit work;

C2: quit;
C1: quit;
