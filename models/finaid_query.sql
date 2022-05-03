{% set award_types = ["Grant","Loan","Scholarship","Work/Study"] %}

SELECT 
     [Student ID]
	 , [Admit Term]
    {% for award_type in award_types %}
    , SUM(CASE WHEN [Award Type] = '{{award_type}}' AND [Award Source] = 'Federal' THEN [Offer Amount] ELSE 0.0 END) as SM_FIN_FED
	, SUM(CASE WHEN [Award Type] = '{{award_type}}' AND [Award Source] = 'State' THEN [Offer Amount] ELSE 0.0 END) as SM_FIN_ST
	, SUM(CASE WHEN [Award Type] = '{{award_type}}' AND [Award Source] = 'Institutional' THEN [Offer Amount] ELSE 0.0 END) as SM_FIN_INST
	, SUM(CASE WHEN [Award Type] = '{{award_type}}' AND [Award Source] = 'Other' THEN [Offer Amount] ELSE 0.0 END) as SM_FIN_OTH
    {% endfor %}
FROM awards 


