-- alter table which create using int,smallint,numeric,float,real,double,monetary,timestamp and range partition on int field having maxvalue  of inserting data to remove partition

create table range_test(id int not null ,
				test_int int,
				test_smallint smallint,
				test_numeric numeric(38,10),
				test_float float,
				test_real real,
				test_double double,
				test_monetary monetary,
				test_datetime timestamp,primary key(id,test_int))
		PARTITION BY RANGE (test_int) (
		PARTITION p0 VALUES LESS THAN (10),
		PARTITION p1 VALUES LESS THAN (20),
		PARTITION p2 VALUES LESS THAN MAXVALUE
	);
	insert into range_test values( 1,1, 2,  1.952491373, 1.040967569,  1.8889608756, 1.438915955,  1,'2007-01-01 09:00:00');
	insert into range_test values( 2,2, 3,  2.102201596, 2.448271838,  2.309828743,  2.862653912,  2,'2007-01-01 09:00:00');
	insert into range_test values( 3,13,14,13.500607386, 13.2760446668,13.861596361, 13.511043858, 13,'2007-01-01 09:00:00');
	insert into range_test values( 4,14,15,14.399696514, 14.436700499, 14.363333523, 14.4,         14,'2007-01-01 09:00:00');
	insert into range_test values( 5,15,16,15.1802523285,15.9167372882,15.6244295835,25.982398624, 15,'2007-01-01 09:00:00');
	insert into range_test values( 6,25,26,25.1802523285,25.9167372882,25.6244295835,25.982398624, 25,'2007-01-01 09:00:00');
	insert into range_test values( 7,26,27,26.1802523285,26.9167372882,26.6244295835,26.982398624, 26,'2007-01-01 09:00:00');
	insert into range_test values(9, null,null,null,null,null,null,null,'2007-01-01 09:00:00');
ALTER TABLE range_test remove partitioning;
select * from range_test order by id;


drop table range_test;
