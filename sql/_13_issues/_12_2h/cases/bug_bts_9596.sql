autocommit off;
create table TESTTBL (field1 INT);
create table RESULTTBL (ts timestamp);
create trigger BATCHTESTRESULT after commit execute after insert into RESULTTBL  values (systimestamp);
insert into testtbl values(1);
commit;
select if((SYSTIMESTAMP - ts) < 2, 'ok', 'nok') as c from resulttbl;
drop trigger BATCHTESTRESULT;
drop table TESTTBL,RESULTTBL;
autocommit on;
