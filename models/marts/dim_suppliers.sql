{{ config(
    materialized='incremental',
) }}

with suppliers as (
    select *
    from {{ ref('int_suppliers') }}
)

select 
    *,
    {{ dbt_meta() }}
from suppliers

{% if is_incremental() %}
    -- only load new or updated rows
    where updated_at > (
        select max(updated_at) from {{ this }}
    )
{% endif %}

