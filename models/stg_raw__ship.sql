with source as (

    select *
    from {{ source('raw', 'ship') }}

)

select
    orders_id,
    shipping_fee,
    log_cost,
    cast(ship_cost as FLOAT64) as ship_cost
from source