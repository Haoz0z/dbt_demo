select
  order_date,
  count(*) as orders_count,
  sum(case when status = 'completed' then order_amount else 0 end) as completed_amount,
  sum(case when status = 'returned' then order_amount else 0 end) as returned_amount
from {{ ref('stg_orders') }}
group by order_date
order by order_date
