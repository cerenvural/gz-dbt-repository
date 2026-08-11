with orders_margin as (
    select *
    from {{ ref('int_orders_margin') }}
),

ship as (
    select *
    from {{ ref('stg_raw__ship') }}
)

select
    orders_margin.*,
    ship.shipping_fee,
    ship.log_cost,
    ship.ship_cost,
    orders_margin.margin
        + ship.shipping_fee
        - ship.log_cost
        - ship.ship_cost as operational_margin
from orders_margin
left join ship
    using (orders_id)
