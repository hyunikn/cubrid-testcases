--+ server-message on

-- normal: basic usage of operator 'in' with bigint values


create or replace procedure t(i int) as
    a bigint := 3;
    b bigint := 5;
    c bigint := 7;

    function print_bool(b boolean) return varchar as
    begin
        return case when b is null then 'null' when b then 'true' else 'false' end;
    end;
begin
    dbms_output.put_line(print_bool(a in (b, c)));
    dbms_output.put_line(print_bool(b in (b, c)));
    dbms_output.put_line(print_bool(null in (b, c)));
    dbms_output.put_line(print_bool(a in (null, c)));
    dbms_output.put_line(print_bool(a in (b, null)));
end;

select * from db_stored_procedure where sp_name = 't';
select * from db_stored_procedure_args where sp_name = 't';

call t(7);

drop procedure t;


--+ server-message off