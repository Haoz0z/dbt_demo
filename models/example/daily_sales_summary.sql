{{ config(materialized='table') }}

with orders as (
    select
        cast(order_date as date) as order_date,
        status,
        cast(amount as numeric) as amount
    from {{ ref('raw_orders') }}
)

select
    order_date,
    count(*) as orders_count,
    sum(case when status = 'completed' then amount else 0 end) as completed_amount,
    sum(case when status = 'returned' then amount else 0 end) as returned_amount
from orders
group by 1
order by 1