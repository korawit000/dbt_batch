{{ config(materialized='table', unique_key='id') }}

with source AS (
SELECT 
id
, username
, email
, created_at
, is_active
FROM schema_data.user_data;
)
select
*
from source

-- {% if is_incremental() %}
--     where dr_no > (select max(dr_no) from {{ this }})
-- {% endif %}



