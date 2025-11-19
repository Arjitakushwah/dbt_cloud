with supplier as (
select 
        -- ids
        s_suppkey as supplier_id,
        s_nationkey as nation_id,

        -- descriptions
        Sname as supplier_name,
        s_address as supplier_address,
        s_phone as phone_number,
        s_comment as comment,

        -- amounts
        s_acctbal as account_balance,
        updated_time
from {{ source('src', 'suppliers') }} a join  {{ source('src4', 'suppliers') }} b on a.s_suppkey = b.Skey
)           
select * from supplier