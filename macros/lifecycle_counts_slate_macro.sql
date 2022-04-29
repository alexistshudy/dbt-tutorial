{% macro lifecycle_counts_slate_macro(
    base_table_name, 
    apps_table_name, 
    base_table_id, 
    apps_table_id, 
    {phase}
    base_table_term, 
    apps_table_term, 
    phase1_name, 
    phase1_date,
    phase1_source,
    phase2_name,
    phase2_date, 
    phase2_source,
     phase3_name,
    phase3_date, 
    phase3_source,
     phase4_name,
    phase4_date, 
    phase4_source,
     phase5_name,
    phase5_date, 
    phase5_source,
     phase6_name,
    phase6_date, 
    phase6_source,
     phase7_name,
    phase7_date, 
    phase7_source,
     phase8_name,
    phase8_date, 
    phase8_source,
     phase9_name,
    phase9_date, 
    phase9_source,
     phase10_name,
    phase10_date, 
    phase10_source,
    enrolled_variable,
    enrolled_condition,
    enrolled_source
    ) 
%}

SELECT
    '{{ base_table_name }}'.'{{ base_table_id }}'
   , COALESCE('{{ apps_table_name }}'.'{{ apps_table_term }}', '{{ base_table_name }}'.'{{ base_table_term }}') AS TERM
   , '{{ phase1_source }}'.'{{ phase1_date }}' AS '{{ phase1_name }}'
   , '{{ phase2_source }}'.'{{ phase2_date }}' AS '{{ phase2_name }}'
   , '{{ phase3_source }}'.'{{ phase3_date }}' AS '{{ phase3_name }}'
   , '{{ phase4_source }}'.'{{ phase4_date }}' AS '{{ phase4_name }}'
   , '{{ phase5_source }}'.'{{ phase5_date }}' AS '{{ phase5_name }}'
   , '{{ phase6_source }}'.'{{ phase6_date }}' AS '{{ phase6_name }}'
   , '{{ phase7_source }}'.'{{ phase7_date }}' AS '{{ phase7_name }}'
   , '{{ phase8_source }}'.'{{ phase8_date }}' AS '{{ phase8_name }}'
   , '{{ phase9_source }}'.'{{ phase9_date }}' AS '{{ phase9_name }}'
   , '{{ phase10_source }}'.'{{ phase10_date }}' AS '{{ phase10_name }}'
   , '{{ enrolled_source }}'.'{{ enrolled_variable }}' AS ENROLLED
FROM '{{ base_table_name }}'
LEFT JOIN '{{ apps_table_name }}'
ON '{{ base_table_name }}'.'{{ base_table_id }}' = '{{ apps_table_name }}'.'{{ apps_table_id }}'


{% endmacro %}
