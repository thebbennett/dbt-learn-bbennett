with  orders as (

    select * from {{ ref ('stg_orders')}}

), stripe_payments as (

    select * from {{ ref('stg_payments')}}


), order_totals as (

  select

    order_id,

    sum(case when payment_status = 'success' then amount_usd end) as amount_total_usd

  from stripe_payments

  group by 1

), final as (

    select

        orders.order_id,

        orders.customer_id,

        orders.order_date,

        coalesce(order_totals.amount_total_usd, 0) as amount_total_usd

    from orders

    left join order_totals

      on orders.order_id = order_totals.order_id

)

select * from final
