--+ server-message on
-- Verified for CBRD-24959
-- normal: basic usage of a builtin function call

create or replace procedure t () as
begin
    dbms_output.put_line(DATE(NULL)); -- parse NULL param error
    dbms_output.put_line(DATE('1999-01-11 12:34:52.333'));
    dbms_output.put_line(DATE('1999-01-11 12:34:52'));
    dbms_output.put_line(DATE('1999-01-11'));
    dbms_output.put_line(DATE('0000-00-00 00:00:00.000'));
    dbms_output.put_line(DATE('0000-00-00 00:00:00'));
    dbms_output.put_line(DATE('0000-00-00'));
end;

select count(*) from db_stored_procedure where sp_name = 't';
select count(*) from db_stored_procedure_args where sp_name = 't';

call t();

drop procedure t;

--+ server-message off
