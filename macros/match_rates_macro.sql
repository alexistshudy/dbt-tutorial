{% macro match_rates_macro(base_table_name, base_id_name, table_name, id_name) %}

SELECT 
[File Name]
, [# In Base & Join]
, [# In Base]
, [# In Join] 
, CAST([# In Base & Join] AS REAL)/CAST([# In Base] AS REAL) AS [Match Rate: Join to Base]
, CAST([# In Base & Join] AS REAL)/CAST([# In Join] AS REAL) AS [Match Rate: Base to Join]
FROM (
SELECT
    '{{ table_name }}' AS [File Name]
    , (SELECT COUNT(*) FROM '{{ base_table_name }}' WHERE '{{ base_id_name}}' IN (SELECT DISTINCT '{{ id_name }}' FROM '{{ table_name }}')) AS [# In Base & Join]
    , (SELECT COUNT(*) FROM '{{ base_table_name }}') AS [# In Base]
    , (SELECT COUNT(*) FROM '{{ table_name }}') [# In Join]
)

{% endmacro %}