{% set event_types = ["SPRING TRAVEL","FALL TRAVEL","CAMPUS EVENTS","GAD","VIRTUAL PANEL","OCI","YIELD","CONSERVATORY","ONLINE EVENTS","VIRTUAL TRAVEL","SUMMER TRAVEL","OUTREACH TRANSPO","MUSIC","SUMMER CONNECT","THURSDAY TALKS","CONNECT WITH GETTYBURG","STEM","MOCK INTERVIEWS"] %}

WITH lc_dates AS (
    SELECT 
        Ref
        , Period
        , [App Submitted] AS APP_DATE
        , [Admit Date] AS ADM_DATE
        , [Deposit Date] AS DEP_DATE
    FROM apps
)
SELECT 
    events.Ref
    , lc_dates.Period
    {% for event_type in event_types $}
    , CASE WHEN SUM(CASE WHEN UPPER(EVENT_CATEGORY)) = '{{event_type}}' AND (EVENT_DATE < APP_DATE OR APP_DATE IS NULL) THEN 1.0 ELSE 0.0 END)>0 THEN 'YES' ELSE 'NO' END as FG_{{event_type_}}_INQ
    , CASE WHEN SUM(CASE WHEN UPPER(EVENT_CATEGORY)) = '{{event_type}}' AND (EVENT_DATE < ADM_DATE OR ADM_DATE IS NULL) THEN 1.0 ELSE 0.0 END)>0 THEN 'YES' ELSE 'NO' END as FG_{{event_type_}}_APP
    , CASE WHEN SUM(CASE WHEN UPPER(EVENT_CATEGORY)) = '{{event_type}}' AND (EVENT_DATE < DEP_DATE OR DEP_DATE IS NULL) THEN 1.0 ELSE 0.0 END)>0 THEN 'YES' ELSE 'NO' END as FG_{{event_type_}}_ADM
    , CASE WHEN SUM(CASE WHEN UPPER(EVENT_CATEGORY)) = '{{event_type}}' THEN 1.0 ELSE 0.0 END)>0 THEN 'YES' ELSE 'NO' END as FG_{{event_type_}}_DEP
    {% endfor %}
FROM events 
LEFT JOIN lc_dates
ON events.Ref = lc_dates.Ref 
GROUP BY events.Ref, lc_dates.Period