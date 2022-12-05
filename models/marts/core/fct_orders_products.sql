
WITH stg_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo_orders') }}
),

stg_order_items AS(
    SELECT *
    FROM {{ ref('stg_sql_server_dbo_order_items')}}
),

stg_promos AS(
    SELECT *
    FROM {{ ref('stg_sql_server_dbo_promos')}}
),


renamed_casted AS (
    SELECT
        OT.order_id 
        , user_id 
        , O.promo_id
        , address_id
        , created_at
        , status_order
        , shipping_cost
        , order_cost
        , order_total
        , OT.product_id
        , OT.quantity
        , tracking_id
        , shipping_service
        , estimated_delivery_at
        , delivered_at
		, DATEDIFF(day, created_at, delivered_at) AS days_to_deliver
        , O.data_removed
        , O.date_load
    FROM stg_orders O
    JOIN stg_order_items OT
    ON O.order_id = OT.order_id
    JOIN stg_promos P
    ON O.promo_id = P.promo_id

    )

SELECT * FROM renamed_casted