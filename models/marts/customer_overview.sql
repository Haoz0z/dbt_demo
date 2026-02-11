with order_enriched as (
  select * from {{ ref('int_order_detail') }}
),

customer_metrics as (
  select
    customer_id,
    count(*) as total_orders,
    sum(case when status = 'completed' then 1 else 0 end) as completed_orders,
    sum(case when status = 'returned' then 1 else 0 end) as returned_orders,
    sum(case when status = 'completed' then order_amount else 0 end) as total_completed_amount,
    sum(case when status = 'returned' then order_amount else 0 end) as total_returned_amount,
    max(order_date) as last_order_date
  from order_enriched
  group by customer_id
),

preferred_payment as (
  select customer_id, payment_method
  from (
    select
      customer_id,
      payment_method,
      count(*) as cnt,
      row_number() over (
        partition by customer_id
        order by count(*) desc, payment_method
      ) as rn
    from order_enriched
    where payment_method is not null
    group by customer_id, payment_method
  ) t
  where rn = 1
)

select
  c.customer_id,
  c.first_name,
  c.last_name,

  coalesce(m.total_orders, 0) as total_orders,
  coalesce(m.completed_orders, 0) as completed_orders,
  coalesce(m.returned_orders, 0) as returned_orders,

  coalesce(m.total_completed_amount, 0) as total_completed_amount,
  coalesce(m.total_returned_amount, 0) as total_returned_amount,

  m.last_order_date,
  p.payment_method as preferred_payment_method
from {{ ref('stg_customers') }} c
left join customer_metrics m
  on c.customer_id = m.customer_id
left join preferred_payment p
  on c.customer_id = p.customer_id
order by c.customer_id
