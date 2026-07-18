with source as (

    select *
    from {{ source('raw', 'sales') }}

)

select
    date_date,
    orders_id,
    ptd_id as products_id,
    revenue,
    quantity
from source