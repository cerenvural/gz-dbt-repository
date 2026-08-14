with source as (

    select *
    from {{ source('raw', 'product') }}

)

select
    products_id,
cast(purchSE_PRICE as FLOAT64) as purchase_price
from source