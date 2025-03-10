--
create table t1(e enum('a', 'b', 'c', 'xyz'));
insert into t1 values (1), ('b'), (3), ('xyz');

select * from t1 order by 1;
select group_concat(e order by e asc) from t1 order by 1;
select max(e) from t1 order by 1;
select min(e) from t1 order by 1;
select sum(e) from t1 order by 1;
select avg(e) from t1 order by 1;
select count(e) from t1 order by 1;
select stddev(e) from t1 order by 1;
select stddev_pop(e) from t1 order by 1;
select var_pop(e) from t1 order by 1;
select var_samp(e) from t1 order by 1;
select variance(e) from t1 order by 1;

select ascii(e) from t1 order by 1;
select bin(e) from t1 order by 1;
select bit_length(e) from t1 order by 1;
select char_length(e) from t1 order by 1;
select character_length(e) from t1 order by 1;
select chr(e) from t1 order by 1;
select concat(e, e) from t1 order by 1;
select concat_ws(e, e, e) from t1 order by 1;
select elt(1, e) from t1 order by 1;
select field(e, 'a', 'b', 'c', 'd', 'xyz') from t1 order by 1;
select find_in_set(e, 'a, b, c, d, e, f, g, h') from t1 order by 1;
select insert(e, 1, 2, 'xx') from t1 order by 1;
select instr('abcdefgh', e) from t1 order by 1;
select lcase(e) from t1 order by 1;
select left(e, 1) from t1 order by 1;
select length(e) from t1 order by 1;
select lengthb(e) from t1 order by 1;
select locate(e, 'abcdefgh') from t1 order by 1;
select lower(e) from t1 order by 1;
select lpad(e, e, e) from t1 order by 1;
select ltrim(e, 'x') from t1 order by 1;
select mid(e, e, e) from t1 order by 1;
select octet_length(e) from t1 order by 1;
select position(e in e) from t1 order by 1;
select repeat(e, e) from t1 order by 1;
select replace(e, e, e) from t1 order by 1;
select reverse(e) from t1 order by 1;
select right(e, e) from t1 order by 1;
select rpad(e, e, e) from t1 order by 1;
select rtrim(e, 'b'), rtrim('abcxyz', e) from t1 order by 1, 2;
select '''' + space(e)  + '''' from t1 order by 1;
select strcmp(e, e) from t1 order by 1;
select substr(e, e, e) from t1 order by 1;
select substring(e, e, e), substring(e from e for e) from t1 order by 1, 2;
select substring_index(e, e, e) from t1 order by 1;
select translate(e, e, e) from t1 order by 1;
select '''' + trim(e from e) + '''' from t1 order by 1;
select ucase(e) from t1 order by 1;
select upper(e) from t1 order by 1;

select abs(e) from t1 order by 1;
select acos(e) from t1 where e <= 1 order by 1;
select asin(e) from t1 where e <= 1 order by 1;
select atan(e), atan(e, e) from t1 order by 1, 2;
select atan2(e, e) from t1 order by 1;
select ceil(e) from t1 order by 1;
select conv(e, 10, e) from t1 order by 1;
select to_char(cos(e), '9.999999') from t1 order by 1;
select substr(to_char(cot(e)),1,15) from t1 order by 1;
--select cot(e) from t1 order by 1;
select degrees(e) from t1 order by 1;
--select exp(e) from t1 order by 1;
select substr(to_char(exp(e)),1,15) from t1 order by 1;
select format(e, e) from t1 order by 1;
select greatest(e, e, e, 2), greatest(e, e, e, 'x') from t1 order by 1, 2;
select greatest(e, e, e, cast(e as int)) from t1 order by 1;
select hex(e) from t1 order by 1;
select least(e, e, e, 2), least(e, e, e, 'x') from t1 order by 1, 2;
select least(e, e, e, cast(e as int)) from t1 order by 1;
select ln(e) from t1 order by 1;
select log2(e) from t1 order by 1;
select log10(e) from t1 order by 1;
select mod(e, e) from t1 order by 1;
select pow(e, e) from t1 order by 1;
select power(e, e) from t1 order by 1;
select radians(e) from t1 order by 1;
select round(e) from t1 order by 1;
select sign(e) from t1 order by 1;
select sin(e) from t1 order by 1;
select sqrt(e) from t1 order by 1;
select tan(e)||'' from t1 order by 1;
select trunc(e, 1), trunc(12345, e) from t1 order by 1, 2;
select truncate(e, 1), truncate(12345, e) from t1 order by 1, 2;

select if (e=1, 0, e), if(e>1, e, 0) from t1 order by 1, 2;
select coalesce(e, e, e, 2) from t1 order by 1;
select decode(e, e, e, 2) from t1 order by 1;
select e, case e when 1 then 10 when 2 then e when 3 then e else e end from t1 order by 1, 2;
select e, case when e=1 then 10 when e=2 then e when e=3 then e else e end from t1 order by 1, 2;
select ifnull(e, null), ifnull(null, e) from t1 order by 1, 2;
select nullif(e, null), nullif(e, e) from t1 order by 1, 2;
select nvl(e, null), nvl(null, e) from t1 order by 1, 2;
select nvl2(e, e, e), nvl2(null, e, e) from t1 order by 1, 2;

select isnull(e) from t1 order by 1;
select * from t1 where e like e order by 1;

select e, md5(e), md5(cast(e as varchar)) from t1 order by 1, 2, 3;

drop table t1;
