with sales as (
    select *
    from {{ ref('stg_raw__sales') }}
),

product as (
    select *
    from {{ ref('stg_raw__product') }}
)

select
    sales.*,
    product.purchase_price,
    sales.quantity * product.purchase_price as purchase_cost,
    sales.revenue - (sales.quantity * product.purchase_price) as margin
from sales
left join product
    using (products_id)