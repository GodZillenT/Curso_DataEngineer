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
          budget_id
        , product_id
        , quantity
        , year(month)*100+month(month) as id_anio_mes_budget
        , _fivetran_synced 
    FROM src_budget_products
    )

SELECT * FROM budget

{% if is_incremental() %}

  where _fivetran_synced  > (select max(_fivetran_synced ) from {{ this }})

{% endif %}