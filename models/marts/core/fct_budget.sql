{{ config(
    materialized='incremental',
    unique_key = '_row'
    ) 
    }}

WITH stg_budget AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets_budget') }}
),


renamed_casted AS (
    SELECT
          _row
        , product_id
        , id_anio_mes_budget
        , quantity 
        , _fivetran_synced 
    FROM stg_budget
    )

SELECT * FROM renamed_casted

{% if is_incremental() %}

  where _fivetran_synced  > (select max(_fivetran_synced ) from {{ this }})

{% endif %}