{% macro file_overview_macro(table_name, id_name, term_name) %}

SELECT
    '{{ table_name }}' AS [File Name]
    , '{{ id_name }}' AS [ID Variable]
    , '{{ term_name }}' AS [Term Variable]
    , GROUP_CONCAT(DISTINCT {{ term_name }}) AS [Terms Included]
    , COUNT(*) AS [Number of Rows]
    , COUNT(DISTINCT {{ id_name}}) AS [# Distinct ID]
    , COUNT(DISTINCT {{ id_name }}|| {{ term_name }}) AS [# Distinct ID & Term]
FROM {{ table_name }}

{% endmacro %}