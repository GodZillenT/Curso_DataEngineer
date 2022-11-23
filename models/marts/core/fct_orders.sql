{%  set status_orders = obtener_valores(ref('stg_sql_server_dbo_orders'), 'status_order') %}

WITH stg_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo_orders') }}
),


renamed_casted AS (
    SELECT
        order_id 
        , user_id 
        , promo_id
        , address_id
        , created_at
        , shipping_cost
        , order_cost
        , order_total
        , tracking_id
        , shipping_service
        , estimated_delivery_at
        , delivered_at
		, DATEDIFF(day, created_at, delivered_at) AS days_to_deliver
        , data_removed
        , date_load
    FROM stg_orders

    )

SELECT * FROM renamed_casted