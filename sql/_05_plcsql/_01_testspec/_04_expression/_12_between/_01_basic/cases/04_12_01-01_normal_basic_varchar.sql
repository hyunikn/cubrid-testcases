--+ server-message on

-- normal: basic usage of operator 'between' with varchar values


create or replace procedure t(i int) as
    a varchar := 'abc';
    b varchar := 'def';
    c varchar := 'ghi';

    function print_bool(b boolean) return varchar as
    begin
        return case when b is null then 'null' when b then 'true' else 'false' end;
    end;
begin
    dbms_output.put_line(print_bool(b between a and c));
    dbms_output.put_line(print_bool(a between b and c));
    dbms_output.put_line(print_bool(null between b and c));
    dbms_output.put_line(print_bool(a between null and c));
    dbms_output.put_line(print_bool(a between b and null));
end;

select * from db_stored_procedure where sp_name = 't';
select * from db_stored_procedure_args where sp_name = 't';

call t(7);

drop procedure t;


--+ server-message off