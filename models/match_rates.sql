--pass in 4 args: 1. base table name, base table join ID var, join table name, join table Id Var

{{ match_rates_macro('customers', 'CustomerId', 'customers', 'CustomerId') }}
UNION
{{ match_rates_macro('customers', 'CustomerId', 'invoices', 'CustomerId') }}