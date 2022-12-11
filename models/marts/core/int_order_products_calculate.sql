with stg_order_items AS(
    SELECT *
    FROM {{ ref('stg_sql_server_dbo_order_items')}}
),

stg_products AS(
    SELECT *
    FROM {{ref('stg_sql_server_dbo_products')}}
),

renamed_casted AS (
    SELECT
        OT.order_id
        , OT.product_id 
        , OT.quantity 
        , OT.quantity * P.price_usd as order_cost_header

    FROM stg_order_items OT
    JOIN stg_products P
    ON OT.product_id = P.product_id
    ORDER BY 1

    )

SELECT * FROM renamed_casted