-- [er]create hash partition table on a double field with size 0

create table hash_test(id int,
			 test_int int,
			 test_smallint smallint,
			 test_numeric numeric(38,10),
			 test_float float,
			 test_real real,
			 test_double double,
			 test_monetary monetary,
			 test_datetime timestamp, primary key(id,test_double))
	PARTITION BY HASH(test_double)
        PARTITIONS 0;

drop class hash_test;
