
WITH stg_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo_orders') }}
),

WITH stg_order_items AS(
    SELECT *
    FROM {{ ref('stg_sql_server_dbo_order_items')}}
),


renamed_casted AS (
    SELECT
        order_id 
        , user_id 
        , promo_id
        , address_id
        , created_at,
        , status_order
        , shipping_cost
        , order_cost
        , order_total
        , tracking_id
        , shipping_service
        , estimated_delivery_at
        , delivered_at
		, days_to_deliver
        , data_removed
        , date_load
    FROM stg_orders O
    JOIN stg_order_items OT
    O.order_id = OT.order_id
    )

SELECT * FROM renamed_casted