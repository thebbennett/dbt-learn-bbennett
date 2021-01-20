with  orders as (

    select * from {{ ref ('stg_orders')}}

), stripe_payments as (

    select * from {{ ref('stg_payments')}}

), final as (

    select

        orders.order_id,

        orders.customer_id,

        stripe_payments.amount_usd

    from orders

    left join stripe_payments

        on orders.order_id = stripe_payments.order_id

)

select * from final
