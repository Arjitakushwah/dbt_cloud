{{ config(
    materialized = 'dynamic_table',
    target_lag = '5 minutes',
    snowflake_warehouse = 'TRANSFORM_WH',
    REFRESH_MODE = 'incremental'
) }}

select
    
    n.name as nation_name,
    count(c.customer_id) as total_cust,
    sum(c.account_balance) as total_bal,

from {{ ref('stg_customers') }} c
join {{ ref('stg_nations') }} n on c.nation_id = n.nation_id
group by n.name