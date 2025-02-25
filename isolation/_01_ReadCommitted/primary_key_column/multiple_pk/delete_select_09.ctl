/*
Test Case: delete & select
Priority: 1
Reference case: 
Author: Lily

Test Point:
Index skip scan.

NUM_CLIENTS = 2
C1: DELETE FROM tb1;
C3: SELECT * FROM tb1 ORDER BY id;
*/

MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;
C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

/* preparation */
C1: DROP TABLE IF EXISTS tb1;
C1: CREATE TABLE tb1(id INT,col VARCHAR(10));
C1: set @newincr=0;
C1: INSERT INTO tb1 SELECT (@newincr:=@newincr+1)%10,(@newincr) FROM db_class a,db_class b,db_class c limit 1000;
C1: set @newincr=0;
C1: UPDATE tb1 SET col='aa' WHERE CAST(col as INT)<10;
C1: ALTER TABLE tb1 ADD PRIMARY KEY (id,col);
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: DELETE FROM tb1 WHERE col LIKE '10_' AND (select sleep(2))=0;
MC: sleep 1;
C2: SELECT * FROM tb1 WHERE col LIKE '99%' order by id;
C2: SELECT * FROM tb1 WHERE col LIKE '10_' order by id;
MC: wait until C2 ready;
C1: commit work;
MC: wait until C1 ready;
C2: SELECT * FROM tb1 WHERE col LIKE '10_' order by id;
C2: quit;
C1: quit;
