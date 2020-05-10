SELECT report as "### DATABASE REPORT: SCHEMAS and TABLES" 
FROM 
-- I generate the list of tables for a given schema with their comments 
-- I format the text in MarkDown

-- TABLES
(SELECT table_name tablex, table_schema schemax, relkind, 0 as ordex, 
--'<sub> ' || case when relkind = 'r' then 'TABLE |' when relkind = 'v' then 'VIEW: **' when relkind = 'e' then 'EXTERNAL TABLE: **' end || 
--replace(table_schema,'_','\_') || '.' || 
'| **'|| replace(table_name,'_','\_')  || '** | <sub>'|| replace(coalesce(obj_description(oid),''),'_','\_') ||'</sub> | '  
as report
FROM information_schema.tables left join (select relkind, pg_class.oid, n.nspname, relname from pg_class JOIN pg_catalog.pg_namespace n ON n.oid = pg_class.relnamespace) x
on table_name= relname and table_schema = x.nspname
WHERE table_schema in (select nspname from pg_catalog.pg_namespace WHERE nspname !~ '^pg_')
) q
-- HERE I INDICATE THE SCHEMA
where schemax = 'data_lupus'
order by 
relkind = 'z' DESC, 
relkind = 'r' DESC, 
relkind = 'e' DESC, 
relkind = 'v' DESC,
tablex, 
ordex;