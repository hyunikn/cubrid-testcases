/*
Test Case: insert & insert
Priority: 1
Reference case:
Author: Rong Xu

Test Point:
X_LOCK on first key OID for unique indexes
two clients insert different rows at the same time
partition id and primary key on the same column

NUM_CLIENTS = 2
C1: set @newincr=0;
C1: insert into t select (@newincr:=@newincr+1),(@newincr)*2 from db_class a,db_class b,db_class c limit 10000;
C2: set @newincr=0;
C2: insert into t select (@newincr:=@newincr+1),(@newincr)*2-1 from db_class a,db_class b,db_class c limit 10000; --expected no block
*/

MC: setup NUM_CLIENTS = 2;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

/* preparation */
C1: drop table if exists t;
C1: create table t(id int primary key,col int) partition by range(id)(partition p1 values less than (10000),partition p2 values less than (20002));
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: set @newincr=0;
C1: insert into t select (@newincr:=@newincr+1)*2,(@newincr) from db_class a,db_class b,db_class c limit 10000;
MC: wait until C1 ready;
C2: set @newincr1=0;
C2: insert into t select (@newincr1:=@newincr1+1)*2-1,(@newincr1) from db_class a,db_class b,db_class c limit 10000;
MC: wait until C2 ready;
C1: commit work;
C2: commit work;
C2: select count(*) from t order by 1;
C2: commit;

C2: quit;
C1: quit;

