{% snapshot scd_orders %}
{{ config(
    target_database='analytics',
    target_schema='scds',
    unique_key = 'o_orderkey',
    strategy = 'check',
    check_cols = ['o_orderpriority','O_ORDERDATE', 'O_COMMENT'],
    hard_deletes='new_record',
    alias= 'scd_orders_02'
)}}
select * from {{ source('src', 'orders') }}
{% endsnapshot %}