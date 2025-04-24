{{ config(materialized='table', unique_key='dr_no') }}

with source AS (
 SELECT 
    nullif(trim(cast(dr_no AS VARCHAR)), '') AS dr_no
    ,CAST("Date Rptd" as date) AS date_rptd
    ,CAST("DATE OCC" as date) AS date_occ
    ,case when nullif(trim(cast("TIME OCC" AS VARCHAR)), '') is not null 
    	then cast("TIME OCC" AS INT) 
    	else cast(null as int) end AS time_occ
    ,case when nullif(trim(cast(area AS VARCHAR)), '') is not null 
    	then cast(area AS INT) 
    	else cast(null as int) end AS area
    ,nullif(trim(cast("AREA NAME" AS VARCHAR)), '') AS area_name
    ,case when nullif(trim(cast("Rpt Dist No" AS VARCHAR)), '') is not null 
    	then cast("Rpt Dist No" AS INT) 
    	else cast(null as int) end AS rpt_dist_no
    ,case when nullif(trim(cast("Part 1-2" AS VARCHAR)), '') is not null 
    	then cast("Part 1-2" AS INT) 
    	else cast(null as int) end AS part_1_2
    ,case when nullif(trim(cast("Crm Cd" AS VARCHAR)), '') is not null 
    	then cast("Crm Cd" AS INT) 
    	else cast(null as int) end AS crm_cd
    ,nullif(trim(cast("Crm Cd Desc" AS VARCHAR)), '') AS crm_cd_desc
    ,nullif(trim(cast(mocodes AS VARCHAR)), '') AS mocodes
    ,case when nullif(trim(cast("Vict Age" AS VARCHAR)), '') is not null then  cast("Vict Age" as int)
    	else cast(null as int) end AS vict_age
    ,case when cast("Vict Age" AS INT) > 0 and cast("Vict Age" AS INT)  < 11 then  '1-10'
			when cast("Vict Age" AS INT) >= 11 and cast("Vict Age" AS INT)  < 21 then  '11-20'
			when cast("Vict Age" AS INT) >= 21 and cast("Vict Age" AS INT)  < 31 then  '21-30'
			when cast("Vict Age" AS INT) >= 31 and cast("Vict Age" AS INT)  < 41 then  '31-40'
			when cast("Vict Age" AS INT) >= 41 and cast("Vict Age" AS INT)  < 51 then  '41-50'
			when cast("Vict Age" AS INT) >= 51 and cast("Vict Age" AS INT)  < 61 then  '51-60'
			when cast("Vict Age" AS INT) >= 61 and cast("Vict Age" AS INT)  < 71 then  '61-70'
			when cast("Vict Age" AS INT) >= 71 and cast("Vict Age" AS INT)  < 81 then  '71-80'
			when cast("Vict Age" AS INT) > 80 then  '80+'
      when cast("Vict Age" AS INT) = 0 then  'N/A'
    	else 'N/A' end as vict_age_range
--    ,nullif(trim(cast("Vict Sex" AS BPCHAR)), '') AS vict_sex
	,case when cast("Vict Sex" AS BPCHAR) = 'M' then 'Male'
	        when cast("Vict Sex" AS BPCHAR) = 'F' then 'Female'
	        when cast("Vict Sex" AS BPCHAR) = 'X' then 'Not specified'
    		else cast(NULL AS BPCHAR) end AS vict_sex
    ,nullif(trim(cast("Vict Descent" AS BPCHAR)), '') AS vict_descent
    ,case when nullif(trim(cast("Premis Cd" AS VARCHAR)), '') is not null 
    	then cast("Premis Cd" AS INT) 
    	else cast(null as int) end AS premis_cd
    ,nullif(trim(cast("Premis Desc" AS VARCHAR)), '') AS premis_desc
    ,nullif(trim(cast("Weapon Used Cd" AS VARCHAR)), '') AS weapon_used_cd
    ,nullif(trim(cast("Weapon Desc" AS VARCHAR)), '') AS weapon_desc
    ,nullif(trim(cast(status AS VARCHAR)), '') AS status
    ,nullif(trim(cast("Status Desc" AS VARCHAR)), '') AS status_desc
    ,case when nullif(trim(cast("Crm Cd 1" AS VARCHAR)), '') is not null 
    	then cast("Crm Cd 1" AS INT) 
    	else cast(null as int) end AS crm_cd_1
    ,case when nullif(trim(cast("Crm Cd 2" AS VARCHAR)), '') is not null 
    	then cast("Crm Cd 2" AS INT) 
    	else cast(null as int) end AS crm_cd_2
    ,case when nullif(trim(cast("Crm Cd 3" AS VARCHAR)), '') is not null 
    	then cast("Crm Cd 3" AS INT) 
    	else cast(null as int) end AS crm_cd_3
    ,case when nullif(trim(cast("Crm Cd 4" AS VARCHAR)), '') is not null 
    	then cast("Crm Cd 4" AS INT) 
    	else cast(null as int) end AS crm_cd_4
    ,nullif(trim(cast("LOCATION" AS VARCHAR)), '') AS location
    ,nullif(trim(cast("Cross Street" AS VARCHAR)), '') AS cross_street
    ,case when nullif(trim(cast(lat AS VARCHAR)), '') is not null 
    	then cast(lat AS FLOAT) 
    	else cast(null as FLOAT) end AS lat
    ,case when nullif(trim(cast(lon AS VARCHAR)), '') is not null 
    	then cast(lon AS FLOAT) 
    	else cast(null as FLOAT) end AS lon
  FROM analytic.crime_data
)
select
*
from source

-- {% if is_incremental() %}
--     where dr_no > (select max(dr_no) from {{ this }})
-- {% endif %}
