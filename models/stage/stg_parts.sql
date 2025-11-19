with source as(
    select * from {{ source('src', 'parts') }}
),

    changed as(
        select 
        --ids
            p_partkey as part_id,
        --descriptions
            p_name as name,
            p_type as type,
            p_size as size,
            p_mfgr as manufacturer,
            p_brand as brand,
            p_container as container,
            p_comment as comment,

            --amounts
            p_retailprice as retail_price,

            --supplier
            -- p_suppkey as supplier_id,
            -- p_availqty as available_quantity,
            -- p_supplycost as supply_cost

            FROM source
 )

 select * from changed
