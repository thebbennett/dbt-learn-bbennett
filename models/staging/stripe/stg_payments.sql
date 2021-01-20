select


  ID as payment_id,

  ORDERID as order_id,

  PAYMENTMETHOD as payment_method,

  case when status = 'success' then 1 else 0 end as payment_status,

  AMOUNT::decimal / 100::decimal as amount_usd,

  CREATED as created_at

from raw.stripe.payment
