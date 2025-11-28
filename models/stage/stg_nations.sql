{{ config(
    query_tag = 'TEST1',
    access= 'public'

) }}

with nation as (
select 
        n_nationkey as nation_id,
        n_name as name,
        n_regionkey as region_id,
        
        updated_at as updated_at,
        {{dbt_meta()}}
from {{ source('src', 'nations') }}
)
select * from nation 