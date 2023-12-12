{{
    config(
        materialized='view'
    )
}}

with final as (
    select 
        store_id || "-" || cast(id as string) as unique_id,
        pk,
        id,
        store_id,
        name,
        email
    from {{ source('apjuice', 'users') }}
)

select 
    *
from
    final