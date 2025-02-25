/*
Test Case: insert & insert
Priority: 1
Reference case:
Author: Rong Xu

Test Point:
insert into t select ... from ... ON DUPLICATE KEY UPDATE ...
A insert on duplicate ...
B insert rows including A inserted row -- expected waiting

NUM_CLIENTS = 2
C1: insert into t values(1,'a');
C2: insert into t values(1,'b'),(2,'c') on duplicate key update id=2; --expected blocked
*/

MC: setup NUM_CLIENTS = 2;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

/* preparation */
C1: drop table if exists t;
C1: create table t(id int primary key AUTO_INCREMENT,col varchar(10));
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: insert into t values(1,'a');
MC: wait until C1 ready;
C2: set @newincr=0;
C2: insert into t select (@newincr:=@newincr+1),'c' from db_class limit 3 on duplicate key update id=2;
MC: wait until C2 blocked;
C1: commit;
MC: wait until C2 ready;
C2: commit;
MC: wait until C2 ready;
/* expected (2,a)(3,c) */
C1: select * from t order by 1,2;
MC: wait until C1 ready;
C2: commit;          

C2: quit;
C1: quit;

