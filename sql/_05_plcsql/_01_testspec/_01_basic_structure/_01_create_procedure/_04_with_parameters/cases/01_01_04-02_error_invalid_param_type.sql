--+ server-message on

-- error: foo is not a type name

create or replace procedure t(a foo) as
begin
    null;
end;

select * from db_stored_procedure where sp_name = 't';
select * from db_stored_procedure_args where sp_name = 't';


--+ server-message off