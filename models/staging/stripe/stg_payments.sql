select


  id as payment_id,

  orderid as order_id,

  paymentmethod as payment_method,

  status as payment_status,

  amount::decimal / 100::decimal as amount_usd,

  created as created_at

from {{ source('stripe','payment') }}
