with orders_margin as (
    select *
    from {{ ref('int_orders_margin') }}
),

ship as (
    select *
    from {{ ref('stg_raw__ship') }}
)

select
    orders_margin.orders_id,
    orders_margin.date_date,
    orders_margin.margin
        + ship.shipping_fee
        - ship.log_cost
        - ship.ship_cost as operational_margin,
    orders_margin.quantity,
    orders_margin.revenue,
    orders_margin.purchase_cost,
    orders_margin.margin,
    ship.shipping_fee,
    ship.log_cost,
    ship.ship_cost
from orders_margin
left join ship
    using (orders_id)