-- This is a test case to verify the CBRD-24400 issue.
-- The problem of comparing the plan with fixed and variable cost each.

drop table if exists u,t,v;

create table t(i int primary key, j int);
create table u(i int primary key, j int, k int, foreign key fk_u_t(j) references t(i));

insert into t select rownum, rownum from _db_class a, _db_class b limit 1500;
insert into u select rownum, rownum % 1500 + 1, rownum from _db_class a, _db_class b, _db_class c limit 2000;
create table v (i int, j int, k int);
insert into v select rownum, rownum % 1500 + 1, rownum from _db_class a, _db_class b, _db_class c limit 2000;
update statistics on all classes;

--@queryplan
select /*+ recompile */ count(*) from u u, t t, v v, t a, t b, t c, t d, t e where u.j = t.i and u.j = v.j and t.i = a.i and a.i = b.i and b.i = c.i and c.i = d.i and d.i = e.i;

drop table if exists u,t,v;
