with nb_products_parcel as (
    select
        parcel_id,
        sum(quantity) as qty,
        count(distinct model_name) as nb_products
    from {{ ref('stg_cc_parcel_products') }}
    group by parcel_id
)

select
    parcel_id,
    parcel_tracking,
    transporter,
    priority,
    date_purchase,
    date_shipping,
    date_delivery,
    date_cancelled,
    extract(month from date_purchase) as month_purchase,
    case
        when date_cancelled is not null then 'İptal Edildi'
        when date_shipping is null then 'Devam Ediyor'
        when date_delivery is null then 'Taşınıyor'
        when date_delivery is not null then 'Teslim Edildi'
        else null
    end as status,
    date_diff(date_shipping, date_purchase, day) as expedition_time,
    date_diff(date_delivery, date_shipping, day) as transport_time,
    date_diff(date_delivery, date_purchase, day) as delivery_time,
    if(
        date_delivery is null,
        null,
        if(date_diff(date_delivery, date_purchase, day) > 5, 1, 0)
    ) as delay,
    qty,
    nb_products
from {{ ref('stg_cc_parcel') }}
left join nb_products_parcel using (parcel_id)