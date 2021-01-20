with  orders as (

    select * from {{ ref ('stg_orders')}}

), stripe_payments as (

    select * from {{ ref('stg_payments')}}


), order_totals as (

  select

    order_id,

    sum(amount_usd) as amount

  from stripe_payments

  group by 1

), final as (

    select

        order_totals.order_id,

        orders.customer_id,

        orders.order_date,

        coalesce(order_totals.amount, 0) as amount

    from orders

    left join order_totals

      on orders.order_id = order_totals.order_id

)

select * from final
