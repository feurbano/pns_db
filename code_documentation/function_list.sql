SELECT   '* **'|| nspname ||'.'|| proname||E'**  \nParametri di input: '
|| case when length(pg_get_function_arguments(p.oid)) > 1 then pg_get_function_arguments(p.oid) else ' nessun parametro di input' end
||E'  \nDescrizione: '|| coalesce(obj_description(p.oid),'NO DESCRIPTION')||'  ' as lista_trigger
FROM    pg_catalog.pg_namespace n
JOIN    pg_catalog.pg_proc p
ON      pronamespace = n.oid
WHERE   nspname not in ('pg_catalog', 'public', 'information_schema')
order by nspname, proname;