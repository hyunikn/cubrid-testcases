--combination with join statements



create table avg_int1(id1 int not null, col1 char(20));
insert into avg_int1 values(1, 'aaa'), (2, 'bbb'), (3, 'ccc'), (4, 'ddd'), (5, 'eee'), (6, 'fff');
insert into avg_int1 values(1, 'fff'), (2, 'eee'), (3, 'ddd'), (4, 'ccc'), (5, 'bbb'), (6, 'aaa');


create table avg_int2(id2 int not null, col1 short);
insert into avg_int2 values(2, 5), (4, 10), (6, 10), (2, 5), (1, 5), (4, 10);



--TEST: without table aliases + over()
select avg_int1.id1, avg_int1.col1, avg_int2.col1, avg(all avg_int2.id2) over() average from avg_int1, avg_int2 where avg_int1.id1=avg_int2.id2 and avg_int2.col1 < 10 order by 1, 2, 3;
--TEST: without table aliases + over(partition by ..)
select avg_int2.id2, avg_int1.col1, avg_int2.col1, avg(avg_int2.id2) over(partition by avg_int1.id1) average from avg_int1, avg_int2 where avg_int1.id1=avg_int2.id2 and avg_int2.col1 < 10 order by 1, 2, 3;


--TEST: inner join + over(order by ...)
select m1.id1, m1.col1, m2.col1, avg(m2.col1) over(order by m1.col1) average from avg_int1 as m1 inner join avg_int2 as m2 on m1.id1=m2.id2 order by 1, 2, 3;
--TEST: inner join + over(partition by ... order by ...)
select m2.id2, m1.col1, m2.col1, avg(distinct m2.col1) over(partition by m1.id1 order by m2.col1) average from avg_int1 as m1 inner join avg_int2 as m2 on m1.id1=m2.id2 order by 1, 2, 3;


--TEST: left outer join + over()
select m2.id2, m1.col1, avg(unique m1.id1) over() average from avg_int1 m1 left outer join avg_int2 m2 on m1.id1=m2.id2 where m1.id1 > (select avg(id1) from avg_int1) order by 1, 2, 3;
--TEST: left outer join + over(partition by ...)
select m2.id2, m2.col1, avg(all m2.col1) over(partition by m1.col1) average from avg_int1 m1 left outer join avg_int2 m2 on m1.id1=m2.id2 where m1.id1 > (select avg(id1) from avg_int1) order by 1, 2, 3;


--TEST: right outer join + over(order by ...)
select m1.id1, m2.col1, m1.col1, avg(distinct m2.id2) over(order by m1.col1, m2.col1) average from avg_int1 m1 right outer join avg_int2 m2 on m1.id1=m2.id2 where m1.id1 < (select avg(id2) from avg_int2) order by 1, 2, 3;
--TEST: right outer join + over(partition by ... order by ...)
select m1.id1, m2.col1, m1.col1, avg(all m2.col1) over(partition by m2.col1 order by m1.id1, m1.col1) average from avg_int1 m1 right outer join avg_int2 m2 on m1.id1=m2.id2 order by m1.id1 order by 1, 2, 3;



drop table avg_int1, avg_int2;






