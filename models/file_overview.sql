{{ file_overview_macro('customers', 'CustomerId', 'CustomerId') }}
UNION
{{ file_overview_macro('invoices', 'CustomerId', 'InvoiceDate') }}