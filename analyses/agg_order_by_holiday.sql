with sg_holidays as (
    select * from {{ ref('sg_holidays') }}
),

sales_items as (
    select * from {{ ref('sales_items') }}
),

sales_by_holiday as (

    select 
        sg_holidays.date_day
        , sg_holidays.is_holiday
        , sum(sales_items.product_cost) as total_sales
    from sg_holidays
    inner join sales_items 
    on sales_items.order_date = sg_holidays.date_day
    group by 1, 2 
    order by 2

)

select 
    is_holiday
    , round(avg(total_sales),2) as average_daily_sales
from sales_by_holiday
group by 1 