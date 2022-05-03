{% set interaction_types = ["MAILING","YIELD_COMM","PLATFORMQ","DEC_LETTER","UNDERS","FINAID","VIRTYIELD","PAYMENT","APPEAL_MERIT","APPEAL_NEEDBASED","STATUS_NOTIFICATION","DEP_EXT","DEPOSIT EXTENSION CORRESPONDENCE","EMAIL","JANUARY INDIVIDUALIZED OUTREACH","DECISION LETTER","ATHLETICS"] %}


WITH lc_dates AS (
	SELECT 
		base.Ref 
		, REPLACE(COALESCE(NULLIF([Period],''),NULLIF([Entry Term],'')),'Fall ','') AS TERM
		, [Prospect Date] AS PRS_DATE
		, [Inquiry Date] AS INQ_DATE
		, [App Submitted] AS APP_DATE
		, [Admit Date] AS ADM_DATE
		, [Deposit Date] AS DEP_DATE
	FROM base
	LEFT JOIN apps 
	ON base.Ref = apps.Ref
	WHERE TERM NOT LIKE 'Spring%'
)
SELECT 
     events.Ref
    , lc_dates.TERM
    {% for interaction_type in interaction_types %}
    , CASE WHEN SUM(CASE WHEN UPPER([Parent Code]) = '{{interaction_type}}' AND [Incoming or Outgoing] = 'Incoming' AND (Date < INQ_DATE OR INQ_DATE IS NULL) THEN 1.0 ELSE 0.0 END)>0 THEN 'YES' ELSE 'NO' END as FG_INT_XXX_PRS
	, CASE WHEN SUM(CASE WHEN UPPER([Parent Code]) = '{{interaction_type}}' AND [Incoming or Outgoing] = 'Incoming' AND (Date < APP_DATE OR APP_DATE IS NULL) THEN 1.0 ELSE 0.0 END)>0 THEN 'YES' ELSE 'NO' END as FG_INT_XXX_INQ
    , CASE WHEN SUM(CASE WHEN UPPER([Parent Code]) = '{{interaction_type}}' AND [Incoming or Outgoing] = 'Incoming' AND (Date < ADM_DATE OR ADM_DATE IS NULL) THEN 1.0 ELSE 0.0 END)>0 THEN 'YES' ELSE 'NO' END as FG_INT_XXX_APP
    , CASE WHEN SUM(CASE WHEN UPPER([Parent Code]) = '{{interaction_type}}' AND [Incoming or Outgoing] = 'Incoming' AND (Date < DEP_DATE OR DEP_DATE IS NULL) THEN 1.0 ELSE 0.0 END)>0 THEN 'YES' ELSE 'NO' END as FG_INT_XXX_ADM
    , CASE WHEN SUM(CASE WHEN UPPER([Parent Code]) = '{{interaction_type}}' AND [Incoming or Outgoing] = 'Incoming' THEN 1.0 ELSE 0.0 END)>0 THEN 'YES' ELSE 'NO' END as FG_INT_XXX_DEP
    {% endfor %}
FROM interactions 
LEFT JOIN lc_dates
ON interactions.Ref = lc_dates.Ref 
GROUP BY interactions.Ref, lc_dates.TERM