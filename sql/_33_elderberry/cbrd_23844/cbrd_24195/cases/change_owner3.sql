/*
 *      12. CHANGE OWNER WITH TRIGGER.
 */

create user u1;
create user u2;
create table t1 (c1 int);
create table t2 (c1 int);
create trigger trig1 after insert on t1 execute insert into t2 values (obj.c1);
call login ('u2') on class db_user;
create table t1 (c1 int);
create table t2 (c1 int);
call login ('dba') on class db_user;
select class_of, unique_name, class_name, owner.name from _db_class where is_system_class % 8 = 0 order by 1,2;
select unique_name, name, owner.name, target_class, action_definition from db_trigger;
insert into t1 values (1);
select * from t2;
alter table t1 owner to u1;
alter table t2 owner to u1;
select class_of, unique_name, class_name, owner.name from _db_class where is_system_class % 8 = 0 order by 1,2;
select unique_name, name, owner.name, target_class, action_definition from db_trigger;
insert into u1.t1 values (2);
select * from u1.t2;
alter table t1 owner to u2;
alter table t2 owner to u2;
select class_of, unique_name, class_name, owner.name from _db_class where is_system_class % 8 = 0 order by 1,2;
select unique_name, name, owner.name, target_class, action_definition from db_trigger;
insert into u1.t1 values (3);
select * from u1.t2;

drop table u2.t2;
drop table u2.t1;
drop table u1.t2;
drop table u1.t1;
drop user u2;
drop user u1;