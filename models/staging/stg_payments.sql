{{ config(materialized='view') }}

select
  cast(order_id as signed) as order_id,
  payment_method,
  cast(amount as decimal(10,2)) as payment_amount
from {{ ref('raw_payments') }}