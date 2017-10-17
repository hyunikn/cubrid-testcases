autocommit off;
drop if exists t;
set names utf8;
select hex('가');
create table t(col1 char(10) collate utf8_ko_cs_uca,col2 varchar(10) collate utf8_ko_cs_uca,col3 nchar(10) collate utf8_ko_cs_uca,col4 NCHAR VARYING(10) collate utf8_ko_cs_uca,col5 string collate utf8_ko_cs_uca);
insert into t values('a','a',N'a',N'a','a');
insert into t values('1','1',N'1',N'1','1');
insert into t values('ō','ō',N'ō',N'ō','ō');
insert into t values('가','가',N'가',N'가','가');
insert into t values('伽','伽',N'伽',N'伽','伽');
insert into t values('힐','힐',N'힐',N'힐','힐');
insert into t values('힐1','힐1',N'힐1',N'힐1','힐1');
select (hex(col1)),col1, count(col1) from t group by col1 order by 1;
select (hex(col2)),col2, count(col1) from t group by col2 order by 1;
select (hex(col3)),col3, count(col1) from t group by col3 order by 1;
select (hex(col4)),col4, count(col1) from t group by col4 order by 1;
select (hex(col5)),col5, count(col1) from t group by col5 order by 1;
select (hex(hex(col1))),col1, count(col3) from t group by col1, col2, col3 order by 1;
select (hex(hex(col2))),col2, count(col3) from t group by col1, col2, col4 order by 1;
select (hex(hex(col3))),col3, count(col3) from t group by col2, col3, col4 order by 1;
select (hex(hex(col4))),col4, count(col3) from t group by col3, col4, col5 order by 1;
select (hex(hex(col5))),col5, count(col3) from t group by col4, col5, col1 order by 1;
drop table t;
set names iso88591;
commit;
autocommit on;