/*
Test Case: Truncate table & select
Priority: 1
Reference case:
Author: Lily

Test Point:
-    Truncate table: SCH_M_LOCK on the table.
-    select: no row locks acquired but IS_LOCK for table.
C1 truncate table, C2 select rows, then C2 is blocked.
when C1 committed, C2 succeeded select. 

NUM_CLIENTS = 2
C1: TRUNCATE TABLE tb1;
C2: select * from tb1 order by id;

*/

MC: setup NUM_CLIENTS = 2;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;

/* preparation */
C1: DROP TABLE IF EXISTS tb1;
C1: CREATE TABLE tb1(id INT AUTO_INCREMENT PRIMARY KEY,col VARCHAR(10),grade INT);
C1: INSERT INTO tb1 VALUES(NULL,'abc', 15);
C1: INSERT INTO tb1 VALUES(NULL,'def', 34);
C1: commit work;

/* test case */
C1: TRUNCATE TABLE tb1;
MC: wait until C1 ready;

C2: select * from tb1 order by id,2,3;
MC: wait until C2 blocked;

C1: commit work;
MC: wait until C1 ready;
MC: wait until C2 ready;

C2: select * from tb1 order by id,2,3;
C2: commit work;
C2: select * from tb1 order by id,2,3;
C2: commit work;
MC: wait until C2 ready;

C2: quit;
C1: quit;
