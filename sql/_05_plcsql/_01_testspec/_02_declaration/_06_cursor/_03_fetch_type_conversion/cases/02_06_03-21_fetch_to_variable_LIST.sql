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


call print_message('t_DATETIME_LIST. This scenario is a failure.');
create or replace procedure t_DATETIME_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_DATETIME FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_DATETIME_LIST('DATETIME', 'LIST'  ) ;
drop procedure t_DATETIME_LIST ;



call print_message('t_DATETIMELTZ_LIST. This scenario is a failure.');
create or replace procedure t_DATETIMELTZ_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_DATETIMELTZ FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_DATETIMELTZ_LIST('DATETIMELTZ', 'LIST'  ) ;
drop procedure t_DATETIMELTZ_LIST ;



call print_message('t_DATETIMETZ_LIST. This scenario is a failure.');
create or replace procedure t_DATETIMETZ_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_DATETIMETZ FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_DATETIMETZ_LIST('DATETIMETZ', 'LIST'  ) ;
drop procedure t_DATETIMETZ_LIST ;



call print_message('t_DATE_LIST. This scenario is a failure.');
create or replace procedure t_DATE_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_DATE FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_DATE_LIST('DATE', 'LIST'  ) ;
drop procedure t_DATE_LIST ;



call print_message('t_TIME_LIST. This scenario is a failure.');
create or replace procedure t_TIME_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_TIME FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_TIME_LIST('TIME', 'LIST'  ) ;
drop procedure t_TIME_LIST ;



call print_message('t_TIMESTAMP_LIST. This scenario is a failure.');
create or replace procedure t_TIMESTAMP_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_TIMESTAMP FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_TIMESTAMP_LIST('TIMESTAMP', 'LIST'  ) ;
drop procedure t_TIMESTAMP_LIST ;



call print_message('t_TIMESTAMPLTZ_LIST. This scenario is a failure.');
create or replace procedure t_TIMESTAMPLTZ_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_TIMESTAMPLTZ FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_TIMESTAMPLTZ_LIST('TIMESTAMPLTZ', 'LIST'  ) ;
drop procedure t_TIMESTAMPLTZ_LIST ;



call print_message('t_TIMESTAMPTZ_LIST. This scenario is a failure.');
create or replace procedure t_TIMESTAMPTZ_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_TIMESTAMPTZ FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_TIMESTAMPTZ_LIST('TIMESTAMPTZ', 'LIST'  ) ;
drop procedure t_TIMESTAMPTZ_LIST ;



call print_message('t_DOUBLE_LIST. This scenario is a failure.');
create or replace procedure t_DOUBLE_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_DOUBLE FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_DOUBLE_LIST('DOUBLE', 'LIST'  ) ;
drop procedure t_DOUBLE_LIST ;



call print_message('t_FLOAT_LIST. This scenario is a failure.');
create or replace procedure t_FLOAT_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_FLOAT FROM plcsql_type_tbl WHERE ID = 1 ;
     CURSOR my_cursor2 IS 
          SELECT T_REAL FROM plcsql_type_tbl WHERE ID = 2 ;

   VAR LIST  ;
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
call t_FLOAT_LIST('FLOAT', 'LIST'  ) ;
drop procedure t_FLOAT_LIST ;



call print_message('t_NUMERIC(8,4)_LIST. This scenario is a failure.');
create or replace procedure t_NUMERIC_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_NUMERIC FROM plcsql_type_tbl WHERE ID = 1 ;
     CURSOR my_cursor2 IS 
          SELECT T_DECIMAL FROM plcsql_type_tbl WHERE ID = 2 ;

   VAR LIST  ;
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
call t_NUMERIC_LIST('NUMERIC(8,4)', 'LIST'  ) ;
drop procedure t_NUMERIC_LIST ;



call print_message('t_BIGINT_LIST. This scenario is a failure.');
create or replace procedure t_BIGINT_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_BIGINT FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_BIGINT_LIST('BIGINT', 'LIST'  ) ;
drop procedure t_BIGINT_LIST ;



call print_message('t_INT_LIST. This scenario is a failure.');
create or replace procedure t_INT_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_INT FROM plcsql_type_tbl WHERE ID = 1 ;
     CURSOR my_cursor2 IS 
          SELECT T_INTEGER FROM plcsql_type_tbl WHERE ID = 2 ;

   VAR LIST  ;
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
call t_INT_LIST('INT', 'LIST'  ) ;
drop procedure t_INT_LIST ;



call print_message('t_SHORT_LIST. This scenario is a failure.');
create or replace procedure t_SHORT_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_SHORT FROM plcsql_type_tbl WHERE ID = 1 ;
     CURSOR my_cursor2 IS 
          SELECT T_SMALLINT FROM plcsql_type_tbl WHERE ID = 2 ;

   VAR LIST  ;
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
call t_SHORT_LIST('SHORT', 'LIST'  ) ;
drop procedure t_SHORT_LIST ;



call print_message('t_BIT(8)_LIST. This scenario is a failure.');
create or replace procedure t_BIT_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_BIT FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_BIT_LIST('BIT(8)', 'LIST'  ) ;
drop procedure t_BIT_LIST ;



call print_message('t_BIT VARYING_LIST. This scenario is a failure.');
create or replace procedure t_BITVARYING_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_BITVARYING FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_BITVARYING_LIST('BIT VARYING', 'LIST'  ) ;
drop procedure t_BITVARYING_LIST ;



call print_message('t_CHAR_LIST. This scenario is a failure.');
create or replace procedure t_CHAR_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_SET FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_CHAR_LIST('CHAR', 'LIST'  ) ;
drop procedure t_CHAR_LIST ;



call print_message('t_VARCHAR_LIST. This scenario is a failure.');
create or replace procedure t_VARCHAR_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_SET FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_VARCHAR_LIST('VARCHAR', 'LIST'  ) ;
drop procedure t_VARCHAR_LIST ;



call print_message('t_SET_LIST. This scenario is a failure.');
create or replace procedure t_SET_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_SET FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_SET_LIST('SET', 'LIST'  ) ;
drop procedure t_SET_LIST ;



call print_message('t_MULTISET_LIST. This scenario is a failure.');
create or replace procedure t_MULTISET_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_MULTISET FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_MULTISET_LIST('MULTISET', 'LIST'  ) ;
drop procedure t_MULTISET_LIST ;



call print_message('t_LIST_LIST. This scenario is a failure.');
create or replace procedure t_LIST_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_LIST FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_LIST_LIST('LIST', 'LIST'  ) ;
drop procedure t_LIST_LIST ;



call print_message('t_ENUM_LIST. This scenario is a failure.');
create or replace procedure t_ENUM_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_ENUM FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_ENUM_LIST('ENUM', 'LIST'  ) ;
drop procedure t_ENUM_LIST ;



call print_message('t_BLOB_LIST. This scenario is a failure.');
create or replace procedure t_BLOB_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_BLOB FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_BLOB_LIST('BLOB', 'LIST'  ) ;
drop procedure t_BLOB_LIST ;



call print_message('t_CLOB_LIST. This scenario is a failure.');
create or replace procedure t_CLOB_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_CLOB FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_CLOB_LIST('CLOB', 'LIST'  ) ;
drop procedure t_CLOB_LIST ;



call print_message('t_JSON_LIST. This scenario is a failure.');
create or replace procedure t_JSON_LIST(param_type string, variables_type string ) as 
     CURSOR my_cursor1 IS 
          SELECT T_JSON FROM plcsql_type_tbl WHERE ID = 1 ;

   VAR LIST  ;
begin
    OPEN my_cursor1 ; 
    LOOP 
        FETCH my_cursor1 INTO VAR;
        EXIT WHEN my_cursor1%NOTFOUND;
        dbms_output.put_line('select_type = ' ||param_type ||', variables_type = '||variables_type||', SELECT column=>INTO variables = '|| VAR ); 
    END LOOP;
    CLOSE my_cursor1;
    
end;
call t_JSON_LIST('JSON', 'LIST'  ) ;
drop procedure t_JSON_LIST ;

drop table IF EXISTS plcsql_type_tbl;

drop procedure print_message;

--+ server-message off
