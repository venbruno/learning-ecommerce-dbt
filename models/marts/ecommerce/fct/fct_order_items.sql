
select
    *
from
    {{ ref('stg_ecommerce_app__order_items') }}