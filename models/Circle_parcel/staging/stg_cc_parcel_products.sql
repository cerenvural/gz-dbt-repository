select
    ParCEL_id as parcel_id,
    Model_mAME as model_name,
    QUANTITY as quantity
from {{ source('raw_data_circle', 'raw_cc_parcel_product') }}