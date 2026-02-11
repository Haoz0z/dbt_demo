{{ config(materialized='view') }}

select
  o.order_id,
  o.order_date,
  o.status,
  o.order_amount,

  o.customer_id,
  c.first_name,
  c.last_name,

  p.payment_method,
  p.payment_amount
from {{ ref('stg_orders') }} o
left join {{ ref('stg_customers') }} c
  on o.customer_id = c.customer_id
left join {{ ref('stg_payments') }} p
  on o.order_id = p.order_id
