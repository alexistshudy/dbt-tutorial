select 
    "{{ var('base_table') }}" AS [File Name]
    , COUNT(*) AS [Number of Rows]
FROM {{ var('base_table') }}
UNION 
select 
    "{{ var('table_1') }}" AS [File Name]
    , COUNT(*) AS [Number of Rows]
FROM {{ var('table_1') }}