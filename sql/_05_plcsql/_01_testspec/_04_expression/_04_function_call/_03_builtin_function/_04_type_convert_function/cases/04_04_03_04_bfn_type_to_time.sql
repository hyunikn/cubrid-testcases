--+ server-message on

-- normal: basic usage of a builtin function call

create or replace procedure t () as
begin
    dbms_output.put_line(TO_TIME(NULL, 'HH24:MI:SS'));
    dbms_output.put_line(TO_TIME('18:41:53.733', NULL));
    dbms_output.put_line(TO_TIME('184153', 'HH24MISS'));
    dbms_output.put_line(TO_TIME('064153', 'HHMISS'));
    dbms_output.put_line(TO_TIME('18:41:53', 'HH24:MI:SS'));
    dbms_output.put_line(TO_TIME('6:41:53 PM', 'HH12:MI:SS PM'));

    dbms_output.put_line('-- TO_TIME(extra)');
    dbms_output.put_line(TO_TIME('HOUR: 13 MINUTE: 10 SECOND: 30', '"HOUR:" HH24 "MINUTE:" MI "SECOND:" SS'));
end;

select count(*) from db_stored_procedure where sp_name = 't';
select count(*) from db_stored_procedure_args where sp_name = 't';

call t();


-- CBRD-25302: TO_TIME 3rd arg parse error
create or replace procedure t () as
begin
    dbms_output.put_line('-- TO_TIME(2 arguments): intl_date_lang=en_US');
    dbms_output.put_line(TO_TIME('6:41:53', 'HH:MI:SS'));
    dbms_output.put_line('-- TO_TIME(3 arguments): intl_date_lang=en_US');
    dbms_output.put_line(TO_TIME('6:41:53', 'HH:MI:SS', 'en_US'));
    dbms_output.put_line(TO_TIME('6:41:53', 'HH:MI:SS', 'ko_KR'));
end;

call t();


set system parameters 'intl_date_lang=ko_KR';

create or replace procedure t () as
begin
    dbms_output.put_line('-- TO_TIME(2 arguments): intl_date_lang=ko_KR');
    dbms_output.put_line(TO_TIME('6:41:53', 'HH:MI:SS'));
    dbms_output.put_line('-- TO_TIME(3 arguments): intl_date_lang=ko_KR');
    dbms_output.put_line(TO_TIME('6:41:53', 'HH:MI:SS', 'en_US'));
    dbms_output.put_line(TO_TIME('6:41:53', 'HH:MI:SS', 'ko_KR'));
end;

call t();

set system parameters 'intl_date_lang=en_US';


drop procedure t;

-- CBRD-25302
prepare st from 'select to_time(?, ?, ?) from dual';
execute st using '6:41:53', 'HH:MI:SS', 'en_US';
drop prepare st;

--+ server-message off
