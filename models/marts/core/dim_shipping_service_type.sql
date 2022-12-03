WITH stg_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo_orders') }}
),


renamed_casted AS (
    SELECT
        distinct md5(shipping_service) as shipping_service_id,
        shipping_service

    FROM stg_orders
    )

SELECT * FROM renamed_casted