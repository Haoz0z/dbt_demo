select
  cast(id as signed) as order_id,
  cast(user_id as signed) as customer_id,
  cast(order_date as date) as order_date,
  status,
  cast(amount as decimal(10,2)) as order_amount
from {{ ref('raw_orders') }}
