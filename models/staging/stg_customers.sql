select
  cast(id as signed) as customer_id,
  first_name,
  last_name
from {{ ref('raw_customers') }}
