select
    date_date,
    count(distinct orders_id) as nb_transactions,
    sum(revenue) as revenue,
    avg(revenue) as average_basket,
    sum(operational_margin) as operational_margin,
    sum(purchase_cost) as purchase_cost,
    sum(shipping_fee) as shipping_fee,
    sum(log_cost) as log_cost,
    sum(quantity) as quantity
from {{ ref('int_orders_operational') }}
group by date_date
order by date_date desc