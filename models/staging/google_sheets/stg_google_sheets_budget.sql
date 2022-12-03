{{ config(
    materialized='incremental',
    unique_key = '_row'
    ) 
    }}


WITH stg_budget AS (
    SELECT * 
    FROM {{ source('google_sheets','budget') }}
    ),

renamed_casted AS (
    SELECT
          _row
        , product_id
        , month as date_id
        , quantity 
        , _fivetran_synced
    FROM stg_budget
    )

SELECT * FROM renamed_casted

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}