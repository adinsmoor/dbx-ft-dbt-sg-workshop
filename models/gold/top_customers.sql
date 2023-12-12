with sales_items as (
    select * from {{ ref('sales_items') }}
),
sales as (
    select * from {{ ref('sales') }}
),
customers as (
    select * from {{ ref('dim_customers') }}
),

final as (
    select 
        sales_items.store_id,
        sales.unique_customer_id,
        customers.name,
        sum(product_cost) as total_spend
    from
        sales_items
        join sales on sales_items.sale_id = sales.id
        join customers on sales.unique_customer_id = customers.unique_id
    where
        sales.unique_customer_id is not null
    group by sales_items.store_id, sales.unique_customer_id, customers.name
    order by total_spend
    limit 100
)

select 
    *
from 
    final