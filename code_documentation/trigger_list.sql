select '* **' ||upper(trigger_name)|| '** (tabella: '   
       ||event_object_schema||'.'|| event_object_table||
       E')  \nEvento: '||action_timing || ' '|| string_agg(event_manipulation, ',')||E'  \nFunzione: *'||
       replace(action_statement, 'EXECUTE PROCEDURE ','')||E'*  \nDescrizione: vedi descrizione funzione associata (attivata da questo trigger)'||E'  \n' as datax
from information_schema.triggers, 
pg_trigger
   where 
   tgname = trigger_name
group by event_object_schema,event_object_table, trigger_name, action_timing, action_statement, coalesce(obj_description(oid, 'pg_trigger'),'NO DESCRIPTION')
order by event_object_schema, trigger_name;
