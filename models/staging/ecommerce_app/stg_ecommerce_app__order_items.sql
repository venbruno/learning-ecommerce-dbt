
select
    *
from {{ source('public', 'order_items') }}