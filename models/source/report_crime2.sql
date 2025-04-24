{{ config(materialized='incremental', unique_key='dr_no') }}

with source as (
SELECT 
  dr_no
  ,date_rptd
  ,date_occ
  ,time_occ
  ,area
  ,area_name
  ,rpt_dist_no
  ,part_1_2
  ,crm_cd
  ,crm_cd_desc
  ,mocodes
  ,vict_age
  ,vict_age AS vict_age_range
  ,vict_sex
  ,vict_descent
  ,premis_cd
  ,premis_desc
  ,weapon_used_cd
  ,weapon_desc
  ,"status"
  ,status_desc
  ,crm_cd_1
  ,crm_cd_2
  ,crm_cd_3
  ,crm_cd_4
  ,"location"
  ,cross_street
  ,lat
  ,lon
FROM analytic.crime_data
)

select
*
from source

{% if is_incremental() %}
    where dr_no > (select max(dr_no) from {{ this }})
{% endif %}
