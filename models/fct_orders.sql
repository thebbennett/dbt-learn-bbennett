with  orders as (

    select * from {{ ref ('stg_orders')}}

), stripe_payments as (

    select * from {{ ref('stg_payments')}}


), order_totals as (

  select

    order_id,

    sum(amount_usd) as order_amount

  from orders

  left join stripe_payments

      on order_totals.order_id = stripe_payments.order_id

  group by 1

), final as (

    select

        order_totals.order_id,

        orders.customer_id,

        sum(stripe_payments.order_amount)

    from order_totals

    left join orders

      on order_totals.order_id = orders.order_id

)

select * from final
