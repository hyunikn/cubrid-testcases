--+ server-message on

drop table IF EXISTS plcsql_type_tbl ;

create table plcsql_type_tbl (
ID INT,
T_SHORT SHORT,
T_SMALLINT SMALLINT,
T_INTEGER INTEGER,
T_INT INT,
T_BIGINT BIGINT,
T_NUMERIC NUMERIC(38,15),
T_DECIMAL DECIMAL,
T_FLOAT FLOAT,
T_REAL REAL,
T_DOUBLE DOUBLE,
T_DATE DATE,
T_TIME TIME,
T_TIMESTAMP TIMESTAMP,
T_DATETIME DATETIME,
T_CHAR CHAR(32),
T_VARCHAR VARCHAR(32),
T_VARCHAR_DATE VARCHAR(32),
T_VARCHAR_TIME VARCHAR(32),
T_VARCHAR_DATETIME VARCHAR(32),
T_VARCHAR_NUMBER VARCHAR(32),
T_BIT BIT(8) default B'1',
T_BITVARYING BIT VARYING(64) default 0xaa,
T_TIMESTAMPLTZ TIMESTAMPLTZ,
T_TIMESTAMPTZ TIMESTAMPTZ,
T_DATETIMELTZ DATETIMELTZ,
T_DATETIMETZ DATETIMETZ,
T_ENUM ENUM('x-small', 'small', 'medium', 'large', 'x-large'),
T_BLOB BLOB,
T_CLOB CLOB,
T_SET SET default {'c','c','c','b','b','a'},
T_MULTISET MULTISET default {'c','c','c','b','b','a'},
T_SEQUENCE SEQUENCE default {'c','c','c','b','b','a'},
T_LIST LIST default {'c','c','c','b','b','a'},
T_JSON JSON
);

insert into plcsql_type_tbl
(ID, T_SHORT, T_SMALLINT, T_INTEGER, T_INT, T_BIGINT, T_NUMERIC, T_DECIMAL, T_FLOAT, T_REAL, T_DOUBLE, 
T_DATE, T_TIME, T_TIMESTAMP, T_DATETIME, 
T_CHAR, T_VARCHAR, 
T_VARCHAR_DATE, T_VARCHAR_TIME, T_VARCHAR_DATETIME, T_VARCHAR_NUMBER,
T_BIT, T_BITVARYING, T_TIMESTAMPLTZ, T_TIMESTAMPTZ, 
T_DATETIMELTZ, T_DATETIMETZ, 
T_ENUM, T_BLOB, T_CLOB, 
T_SET, T_MULTISET, T_SEQUENCE, T_LIST, T_JSON
)
values
(1, -32767,-32767,-21474, -2147, -9223, 0.1, 0.1, -3.4028234, -3.402823, -1.7976931348623,
'0001-01-01', TIME'00:00:00', '1970-01-01 09:00:01', '0001-01-01 00:00:00.000',
'1234567890abcdef','1234567890abcdef', 
'09/01/2005', '05:05:05 pm', '09/01/2005 05:05:05 pm', '123',
B'1',0xcf,timestampltz'1970-01-01 09:00:01', timestamptz'1970-01-01 09:00:01',
datetimeltz'0001-01-01 09:00:01.000', datetimetz'0001-01-01 09:00:01.000', 
'x-small', BIT_TO_BLOB(X'000100'), CHAR_TO_CLOB('This is a Cat'), 
{'c','c','c','b','b','a'}, {'c','c','c','b','b','a'}, {'c','c','c','b','b','a'}, {'c','c','c','b','b','a'}, '{"key1": "value1", "key2": "value2"}' );

insert into plcsql_type_tbl
(ID, T_SHORT, T_SMALLINT, T_INTEGER, T_INT, T_BIGINT, T_NUMERIC, T_DECIMAL, T_FLOAT, T_REAL, T_DOUBLE, 
T_DATE, T_TIME, T_TIMESTAMP, T_DATETIME, 
T_CHAR, T_VARCHAR,
T_VARCHAR_DATE, T_VARCHAR_TIME, T_VARCHAR_DATETIME, T_VARCHAR_NUMBER,
T_BIT, T_BITVARYING, T_TIMESTAMPLTZ, T_TIMESTAMPTZ, 
T_DATETIMELTZ, T_DATETIMETZ, 
T_ENUM, T_BLOB, T_CLOB, 
T_SET, T_MULTISET, T_SEQUENCE, T_LIST, T_JSON
)
values
(2,32767, 32767, 21474, 2147, 9223, 987.432, 5432, 3.4028, 3.402823466, 3.402823,
'9999-12-31', TIME '23:59:59', '2038-01-19 03:14:07', '9999-12-31 23:59:59.999', 
'1234567890abcdef','1234567890abcdef',
'09/01/2019', '09:09:09 pm', '09/01/2019 09:09:09 pm', '567',
B'1',0xcf,timestampltz'1970-01-01 09:00:01', timestamptz'1970-01-01 09:00:01',
datetimeltz'0001-01-01 09:00:01.000', datetimetz'0001-01-01 09:00:01.000', 
'x-small', BIT_TO_BLOB(X'000100'), CHAR_TO_CLOB('This is a Cat'), 
{'c','c','c','b','b','a'}, {'c','c','c','b','b','a'}, {'c','c','c','b','b','a'}, {'c','c','c','b','b','a'}, '{"key1": "value1", "key2": "value2"}'  );

create or replace procedure print_message(print_message string ) as begin
    dbms_output.put_line( print_message ); 
end;


call print_message('t_DATETIME_MULTISET. This scenario is a failure.');
create or replace procedure t_DATETIME_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_DATETIME FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_DATETIME_MULTISET('DATETIME', 'MULTISET'  ) ;
drop procedure t_DATETIME_MULTISET ;



call print_message('t_DATETIMELTZ_MULTISET. This scenario is a failure.');
create or replace procedure t_DATETIMELTZ_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_DATETIMELTZ FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_DATETIMELTZ_MULTISET('DATETIMELTZ', 'MULTISET'  ) ;
drop procedure t_DATETIMELTZ_MULTISET ;



call print_message('t_DATETIMETZ_MULTISET. This scenario is a failure.');
create or replace procedure t_DATETIMETZ_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_DATETIMETZ FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_DATETIMETZ_MULTISET('DATETIMETZ', 'MULTISET'  ) ;
drop procedure t_DATETIMETZ_MULTISET ;



call print_message('t_DATE_MULTISET. This scenario is a failure.');
create or replace procedure t_DATE_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_DATE FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_DATE_MULTISET('DATE', 'MULTISET'  ) ;
drop procedure t_DATE_MULTISET ;



call print_message('t_TIME_MULTISET. This scenario is a failure.');
create or replace procedure t_TIME_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_TIME FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_TIME_MULTISET('TIME', 'MULTISET'  ) ;
drop procedure t_TIME_MULTISET ;



call print_message('t_TIMESTAMP_MULTISET. This scenario is a failure.');
create or replace procedure t_TIMESTAMP_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_TIMESTAMP FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_TIMESTAMP_MULTISET('TIMESTAMP', 'MULTISET'  ) ;
drop procedure t_TIMESTAMP_MULTISET ;



call print_message('t_TIMESTAMPLTZ_MULTISET. This scenario is a failure.');
create or replace procedure t_TIMESTAMPLTZ_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_TIMESTAMPLTZ FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_TIMESTAMPLTZ_MULTISET('TIMESTAMPLTZ', 'MULTISET'  ) ;
drop procedure t_TIMESTAMPLTZ_MULTISET ;



call print_message('t_TIMESTAMPTZ_MULTISET. This scenario is a failure.');
create or replace procedure t_TIMESTAMPTZ_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_TIMESTAMPTZ FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_TIMESTAMPTZ_MULTISET('TIMESTAMPTZ', 'MULTISET'  ) ;
drop procedure t_TIMESTAMPTZ_MULTISET ;



call print_message('t_DOUBLE_MULTISET. This scenario is a failure.');
create or replace procedure t_DOUBLE_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_DOUBLE FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_DOUBLE_MULTISET('DOUBLE', 'MULTISET'  ) ;
drop procedure t_DOUBLE_MULTISET ;



call print_message('t_FLOAT_MULTISET. This scenario is a failure.');
create or replace procedure t_FLOAT_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_FLOAT FROM plcsql_type_tbl WHERE ID = 1 ;
     CURSOR my_cursor2 IS 
          SELECT T_REAL FROM plcsql_type_tbl WHERE ID = 2 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
    OPEN my_cursor2 ; 
    LOOP 
        FETCH my_cursor2 INTO VAR;
        EXIT WHEN my_cursor2%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor2;
    
end;
call t_FLOAT_MULTISET('FLOAT', 'MULTISET'  ) ;
drop procedure t_FLOAT_MULTISET ;



call print_message('t_NUMERIC(8,4)_MULTISET. This scenario is a failure.');
create or replace procedure t_NUMERIC_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_NUMERIC FROM plcsql_type_tbl WHERE ID = 1 ;
     CURSOR my_cursor2 IS 
          SELECT T_DECIMAL FROM plcsql_type_tbl WHERE ID = 2 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
    OPEN my_cursor2 ; 
    LOOP 
        FETCH my_cursor2 INTO VAR;
        EXIT WHEN my_cursor2%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor2;
    
end;
call t_NUMERIC_MULTISET('NUMERIC(8,4)', 'MULTISET'  ) ;
drop procedure t_NUMERIC_MULTISET ;



call print_message('t_BIGINT_MULTISET. This scenario is a failure.');
create or replace procedure t_BIGINT_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_BIGINT FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_BIGINT_MULTISET('BIGINT', 'MULTISET'  ) ;
drop procedure t_BIGINT_MULTISET ;



call print_message('t_INT_MULTISET. This scenario is a failure.');
create or replace procedure t_INT_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_INT FROM plcsql_type_tbl WHERE ID = 1 ;
     CURSOR my_cursor2 IS 
          SELECT T_INTEGER FROM plcsql_type_tbl WHERE ID = 2 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
    OPEN my_cursor2 ; 
    LOOP 
        FETCH my_cursor2 INTO VAR;
        EXIT WHEN my_cursor2%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor2;
    
end;
call t_INT_MULTISET('INT', 'MULTISET'  ) ;
drop procedure t_INT_MULTISET ;



call print_message('t_SHORT_MULTISET. This scenario is a failure.');
create or replace procedure t_SHORT_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_SHORT FROM plcsql_type_tbl WHERE ID = 1 ;
     CURSOR my_cursor2 IS 
          SELECT T_SMALLINT FROM plcsql_type_tbl WHERE ID = 2 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
    OPEN my_cursor2 ; 
    LOOP 
        FETCH my_cursor2 INTO VAR;
        EXIT WHEN my_cursor2%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor2;
    
end;
call t_SHORT_MULTISET('SHORT', 'MULTISET'  ) ;
drop procedure t_SHORT_MULTISET ;



call print_message('t_BIT(8)_MULTISET. This scenario is a failure.');
create or replace procedure t_BIT_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_BIT FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_BIT_MULTISET('BIT(8)', 'MULTISET'  ) ;
drop procedure t_BIT_MULTISET ;



call print_message('t_BIT VARYING_MULTISET. This scenario is a failure.');
create or replace procedure t_BITVARYING_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_BITVARYING FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_BITVARYING_MULTISET('BIT VARYING', 'MULTISET'  ) ;
drop procedure t_BITVARYING_MULTISET ;



call print_message('t_CHAR_MULTISET. This scenario is a failure.');
create or replace procedure t_CHAR_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_SET FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_CHAR_MULTISET('CHAR', 'MULTISET'  ) ;
drop procedure t_CHAR_MULTISET ;



call print_message('t_VARCHAR_MULTISET. This scenario is a failure.');
create or replace procedure t_VARCHAR_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_SET FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_VARCHAR_MULTISET('VARCHAR', 'MULTISET'  ) ;
drop procedure t_VARCHAR_MULTISET ;



call print_message('t_SET_MULTISET. This scenario is a failure.');
create or replace procedure t_SET_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_SET FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_SET_MULTISET('SET', 'MULTISET'  ) ;
drop procedure t_SET_MULTISET ;



call print_message('t_MULTISET_MULTISET. This scenario is a failure.');
create or replace procedure t_MULTISET_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_MULTISET FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_MULTISET_MULTISET('MULTISET', 'MULTISET'  ) ;
drop procedure t_MULTISET_MULTISET ;



call print_message('t_LIST_MULTISET. This scenario is a failure.');
create or replace procedure t_LIST_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_LIST FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_LIST_MULTISET('LIST', 'MULTISET'  ) ;
drop procedure t_LIST_MULTISET ;



call print_message('t_ENUM_MULTISET. This scenario is a failure.');
create or replace procedure t_ENUM_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_ENUM FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_ENUM_MULTISET('ENUM', 'MULTISET'  ) ;
drop procedure t_ENUM_MULTISET ;



call print_message('t_BLOB_MULTISET. This scenario is a failure.');
create or replace procedure t_BLOB_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_BLOB FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_BLOB_MULTISET('BLOB', 'MULTISET'  ) ;
drop procedure t_BLOB_MULTISET ;



call print_message('t_CLOB_MULTISET. This scenario is a failure.');
create or replace procedure t_CLOB_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_CLOB FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_CLOB_MULTISET('CLOB', 'MULTISET'  ) ;
drop procedure t_CLOB_MULTISET ;



call print_message('t_JSON_MULTISET. This scenario is a failure.');
create or replace procedure t_JSON_MULTISET(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_JSON FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR MULTISET  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_JSON_MULTISET('JSON', 'MULTISET'  ) ;
drop procedure t_JSON_MULTISET ;

drop table IF EXISTS plcsql_type_tbl;

drop procedure print_message;

--+ server-message off
