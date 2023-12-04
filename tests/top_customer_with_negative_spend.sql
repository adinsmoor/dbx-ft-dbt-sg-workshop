{{
    config(
        error_if = '>10'
        , warn_if = '>0'
    )
}}

select 
    *
from
    {{ ref('top_customers') }}
where 
    total_spend < 0