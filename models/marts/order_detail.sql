{{ config(materialized='view') }}

with customers as (
    select
        cast(id as signed) as customer_id,
        first_name,
        last_name
    from {{ ref('raw_customers') }}
),

orders as (
    select
        cast(id as signed) as order_id,
        cast(user_id as signed) as customer_id,
        cast(order_date as date) as order_date,
        status,
        cast(amount as decimal(10,2)) as order_amount
    from {{ ref('raw_orders') }}
),

payments as (
    select
        cast(order_id as signed) as order_id,
        payment_method,
        cast(amount as decimal(10,2)) as payment_amount
    from {{ ref('raw_payments') }}
)

select
    o.order_id,
    o.order_date,
    o.status,
    o.order_amount,

    c.customer_id,
    c.first_name,
    c.last_name,

    p.payment_method,
    p.payment_amount
from orders o
left join customers c
    on o.customer_id = c.customer_id
left join payments p
    on o.order_id = p.order_id
order by o.order_id