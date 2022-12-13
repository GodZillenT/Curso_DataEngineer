{{ config(
    materialized='incremental',
    unique_key = 'budget_id'
    ) 
    }}
--Creamos la tabla CTE desde donde accede a los datos--
WITH src_budget_products AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
    ),

--Creamos la vista --
budget AS (
    SELECT
          _row as budget_id
        , product_id
        , quantity
        , year(month)*100+month(month) as id_anio_mes_budget
        , _fivetran_synced as date_load
    FROM src_budget_products
    )

SELECT * FROM budget

{% if is_incremental() %}

  where date_load  > (select max(date_load ) from {{ this }})

{% endif %}