with source as(
    select * from {{ source('src', 'lineitems') }}
),

changed as(
    select 
        --ids
        {{dbt_utils.generate_surrogate_key(['l_orderkey','l_partkey']) }} as order_item_id,

        l_orderkey as order_id,
        l_partkey as part_id,
        l_suppkey as supplier_id,
        
        
        --descriptions
        l_linenumber as line_number,
        l_comment as comment,
        l_shipmode as ship_mode,
        l_shipinstruct as ship_instruction,

        --dates
        l_shipdate as ship_date,
        l_commitdate as commit_date,
        l_receiptdate as receipt_date,
        
        --status
        l_returnflag as return_flag,
        l_linestatus as line_status,
   
       
        
        --numbers
        l_quantity as quantity,
        l_extendedprice as extended_price,
        l_discount as discount_percent,
        l_tax as tax_rate,
        
    from source
)
select * from changed