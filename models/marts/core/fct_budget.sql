WITH stg_budget AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets_budget') }}
),


renamed_casted AS (
    SELECT
          _row
        , product_id
        , date_id
        , quantity 
        , date_load
    FROM stg_budget
    )

SELECT * FROM renamed_casted