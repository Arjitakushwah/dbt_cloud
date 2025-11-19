{% macro jodo(col1,col2) %}
    {{ col1 }} || ' ' || {{ col2 }}
{% endmacro %}

{% macro clean_gender(gender_column) %}
    
    CASE
        WHEN LOWER(TRIM({{ gender_column }})) = 'm' THEN 'Male'
        WHEN LOWER(TRIM({{ gender_column }})) = 'f' THEN 'Female'
        ELSE 'Unknown'
    END

{% endmacro %}


{% macro categorize_age_group(age_column) %}
    
    CASE
        WHEN {{ age_column }} < 35 THEN 'Youngster'
        WHEN {{ age_column }} < 60 THEN 'Middle'
        WHEN {{ age_column }} >= 60 THEN 'Senior'
        ELSE 'Unknown' -- Added an else for robustness
    END

{% endmacro %}

{% macro format_phone_number(phone_column) %}

    '(' || SUBSTR({{ phone_column }}, 1, 3) || ') ' || SUBSTR({{ phone_column }}, 4, 3) || '-' || SUBSTR({{ phone_column }}, 7, 4)

{% endmacro %}

{% macro show_emps() %}
    select  employee_name from {{ ref('stg_employees') }}
{% endmacro %}

{% macro showemps() %}

    {% set results = run_query("select employee_name from " ~ ref('stg_employees')) %}

    {% if execute %}
        {% for row in results.rows %}
            {{ print(row[0]) }}
        {% endfor %}
    {% endif %}
{% endmacro %}


{% macro upload() %}

{% do run_query("create or replace stage stage_analytics") %}
{% do run_query("copy into @stg_analytics from stg_nations    
partition by (region_name) file_format= (type=csv compression=none null_if(' ')) header=true;") %}

{% endmacro %}

{% macro unload()%}
{% do run_query("create or replace stage stage_analytics") %}
{% do run_query("copy into @stage_analytics from stg_nations partition by (region_id)
file_format= (type = csv compression=none null_if=(' ')) header=true ; ") %}
{% endmacro %}

