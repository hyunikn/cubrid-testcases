--+ server-message on

-- error: local function may not reach the end of the body without encountering a return statement

create or replace procedure t(i int) as
    function foo return int as
    begin
        if true then
            return 0;
        else
            null;
        end if;
    end;    -- actually unreachable, but compiler judges it reachable
begin
    null;
end;

select * from db_stored_procedure where sp_name = 't';
select * from db_stored_procedure_args where sp_name = 't';


--+ server-message off