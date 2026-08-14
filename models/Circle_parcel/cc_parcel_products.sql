{{ config(materialized='table') }}

select
    products.parcel_id,
    products.model_name,
    parcel.parcel_tracking,
    parcel.transporter,
    parcel.priority,
    parcel.date_purchase,
    parcel.date_shipping,
    parcel.date_delivery,
    parcel.date_cancelled,
    parcel.month_purchase,
    parcel.status,
    parcel.expedition_time,
    parcel.transport_time,
    parcel.delivery_time,
    parcel.delay,
    products.quantity as qty
from {{ ref('stg_cc_parcel_products') }} as products
left join {{ ref('cc_parcel') }} as parcel
    using (parcel_id)