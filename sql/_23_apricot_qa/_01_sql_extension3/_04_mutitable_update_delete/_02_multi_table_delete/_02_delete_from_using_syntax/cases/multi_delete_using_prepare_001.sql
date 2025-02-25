--TEST: delete with prepare statement, multi-table delete with prepare statements



create table md_time1(id1 bigint, col1 time not null, primary key(id1, col1 asc));

prepare stm1 from 'insert into md_time1 values(?, ?)';
execute stm1 using 1000000, '12:12:12';
execute stm1 using 2000000, '12:12:13';
execute stm1 using 3000000, '12:12:14';
execute stm1 using 4000000, '12:12:15';
execute stm1 using 5000000, '12:12:16';
execute stm1 using 6000000, '12:12:17';
execute stm1 using 7000000, '12:12:15';
deallocate prepare stm1;;


create table md_time2(col1 varchar(1024), id2 bigint primary key, col2 time);

prepare stmt from 'insert into md_time2 values(?, ?, ?)';
execute stmt using 'cubrid', 1111111, '11:11:11';
execute stmt using 'abc', 2222222, '12:12:12';
execute stmt using 'a', 5000000, '12:12:15';
execute stmt using 'abcabc', 4444444, '10:10:10';
execute stmt using 'aa', 5555555, '12:12:13';
execute stmt using 'mysql', 2000000, '12:12:13';
execute stmt using 'cubridcubrid', 6666666, '13:13:13';
execute stmt using 'mysqlmysql', 4000000, '12:12:16';
execute stmt using 'aaaa', 565656565, '12:12:12';
execute stmt using 'abcabcabc', 6000000, '12:12:16';
execute stmt using 'hello', 7788777, '14:14:14';
execute stmt using 'hellohello', 90000909, '12:12:17';
deallocate prepare stmt;


select * from md_time1 order by 1;
select * from md_time2 order by 1;


--TEST: delete with prepare statement, without table aliases, 2 rows deleted
prepare stmt from 'delete from md_time1, md_time2 using md_time1, md_time2 where md_time1.col1=md_time2.col2 and md_time1.id1=md_time2.id2 and length(trim(md_time2.col1))>?';
execute stmt using 2;
deallocate prepare stmt;
select * from md_time1 order by 1;
select * from md_time2 order by 1;


--TEST: delete with prepare statement, error, group by clause in delete statement
prepare stmt from 'delete from m1, m2 using md_time1 m1, md_time2 m2 where m1.col1 > m2.col2 group by m2.col1';
execute stmt;
deallocate prepare stmt;
select if (count(*) = 6, 'ok', 'nok') from md_time1;
select if (count(*) = 11, 'ok', 'nok') from md_time2;


--TEST: delete with prepare statement, inner join, 2 rows deleted
prepare stmt from 'delete from m1.* using md_time1 as m1 inner join (select id2, time(col2) as col2 from md_time2 where second(col2)=?) as m2 on m1.col1=m2.col2';
execute stmt using 15;
deallocate prepare stmt;
select * from md_time1 order by 1;
prepare stmt from 'select case when count(*) = ? then ? else ? end from md_time2;';
execute stmt using 11, 'ok', 'nok';
deallocate prepare stmt; 


--TEST: delete with prepare statement, delete and select from the same table
prepare stmt from 'delete from m1, md_time2 using md_time1 m1 left outer join md_time2 on m1.col1=md_time2.col2 where m1.id1 > (select avg(id1) from md_time1)';
execute stmt;
deallocate prepare stmt;
select if (count(*) = 2, 'ok', 'nok') from md_time1;
select if (count(*) = 8, 'ok', 'nok') from md_time2;


--TEST: delete with prepare statement, right outer join
--TEST: delete with prepare statement, delete and select from the same table
prepare stmt from 'delete from m1, m2 using md_time1 m1 right outer join md_time2 m2 on m1.col1=m2.col2 where m1.id1 < (select avg(id2) from md_time2)';
execute stmt;
deallocate prepare stmt;
select if (count(*) = 1, 'ok', 'nok') from md_time1;
select if (count(*) = 6, 'ok', 'nok') from md_time2;



drop table md_time1, md_time2;






