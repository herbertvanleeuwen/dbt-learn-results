with orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),


grouped_payments as(
    select
        order_id,
        sum(amount) as total_amount
    from {{ ref('stg_stripe__payments') }}
    where status = 'success'
    group by order_id
),

final as (
    select 
        orders.order_id,
        grouped_payments.total_amount
    from orders left join grouped_payments using (order_id)
)

select * from final