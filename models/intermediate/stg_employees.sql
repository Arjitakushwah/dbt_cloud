with source as(
    select * from {{ source('src1', 'stg_employees') }}
),
changed as (
-- 2. Select and rename columns (snake_case is the dbt standard)
SELECT
    key.nextval AS employee_key,
    EMPLOYEE_ID AS employee_id,
    {{ jodo('employee_first_name', 'employee_last_name' ) }} as employee_name,
    EMPLOYEE_ADDRESS AS employee_address,
    EMPLOYEE_CITY AS employee_city,
    EMPLOYEE_STATE AS employee_state,
    EMPLOYEE_ZIP_CODE AS employee_zip_code,
    {{ format_phone_number('EMPLOYEE_MOBILE') }} AS EMPLOYEE_MOBILE,
    EMPLOYEE_FIXEDLINE AS employee_fixed_line,
    EMPLOYEE_EMAIL AS employee_email,
    {{ clean_gender('EMPLOYEE_GENDER') }} AS employee_gender,
    EMPLOYEE_AGE AS employee_age,
    {{ categorize_age_group('EMPLOYEE_AGE') }} AS age_group,
    POSITION_TYPE AS position_type,
    DEALERSHIP_ID AS dealership_id,
   DEALERSHIP_MANAGER AS DEALERSHIP_MANAGER,
    SALARY AS EMPLOYEE_SALARY,
    REGION AS EMPLOYEE_REGION,
    HIRE_DATE AS HIRED_DATE_KEY,
    DATE_ENTERED AS INSERT_DK,
    DATE_ENTERED AS UPDATE_DK,


FROM
    source
    )

select * from changed