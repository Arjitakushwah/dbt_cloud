{% macro add_updated_at_column(table_name, schema_name=target.schema, database_name=target.database) %}
    ALTER TABLE {{ database_name }}.{{ schema_name }}.{{ table_name }}
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
{% endmacro %}

{% macro modtab(table_name) %}
    {% do run_query(
        "ALTER TABLE " ~ table_name ~
        " ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP;"
    ) %}
{% endmacro %}
