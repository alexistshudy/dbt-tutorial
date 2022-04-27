select 
    '{{ var('base_table') }}' AS [File Name]
    , '{{ var('base_table_id') }}' AS [ID Variable]
    , '{{ var('base_table_term') }}' AS [Term Variable]
    , COUNT(*) AS [Number of Rows]
    , COUNT(DISTINCT {{ var('base_table_id') }}) AS [# Distinct ID]
    , COUNT(DISTINCT {{ var('base_table_id') }}||{{ var('base_table_term') }}) AS [# Distinct ID & Term]
FROM {{ var('base_table') }}
UNION 
select 
    '{{ var('table_1') }}' AS [File Name]
    , '{{ var('table_1_id') }}' AS [ID Variable]
    , '{{ var('table_1_term') }}' AS [Term Variable]
    , COUNT(*) AS [Number of Rows]
    , COUNT(DISTINCT {{ var('table_1_id') }}) AS [# Distinct ID]
    , COUNT(DISTINCT {{ var('table_1_id') }}||{{ var('table_1_term') }}) AS [# Distinct ID & Term]
FROM {{ var('table_1') }}