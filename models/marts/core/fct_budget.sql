{{ config(
    materialized='incremental',
    unique_key = 'budget_id'
    ) 
    }}

WITH stg_budget AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets_budget') }}
),


renamed_casted AS (
    SELECT
          budget_id
        , product_id
        , id_anio_mes_budget
        , quantity 
        , date_load
    FROM stg_budget
    )

SELECT * FROM renamed_casted

{% if is_incremental() %}

  where date_load  > (select max(date_load ) from {{ this }})

{% endif %}