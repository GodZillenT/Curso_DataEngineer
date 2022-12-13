{{ config(
    materialized='incremental',
    unique_key = 'order_product_pk'
    ) 
    }}
WITH stg_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo_orders') }}
),

cont_headers AS(
    SELECT distinct order_id, count(product_id) as order_headers
    FROM {{ref('stg_sql_server_dbo_order_items')}} group by order_id
),

stg_order_items AS(
    SELECT *
    FROM {{ref('stg_sql_server_dbo_order_items')}}
),

stg_promos AS(
    SELECT *
    FROM {{ ref('stg_sql_server_dbo_promos')}}
),

stg_products AS(
    SELECT * 
    FROM {{ref('stg_sql_server_dbo_products')}}
),

renamed_casted AS (
    SELECT
        md5(concat(O.order_id,PD.product_id)) as order_product_pk
        , O.order_id
        , PD.product_id 
        , user_id 
        , O.promo_id
        , address_id
        , created_at
        , status_order
        , shipping_service
        , (shipping_cost / order_headers)::numeric(6,2) as shipping_header_cost
        , OT.quantity
        , (OT.quantity * PD.price_usd)::numeric(6,2) as order_header_cost
        , (order_header_cost + shipping_header_cost) - (P.discount/order_headers)::numeric(6,2) as order_header_total_cost
        , tracking_id
        , estimated_delivery_at
        , delivered_at
		, DATEDIFF(day, created_at, delivered_at) AS days_to_deliver
        , O.data_removed
        , O.date_load
    FROM stg_orders O
    JOIN stg_promos P
    ON O.promo_id = P.promo_id
    JOIN stg_order_items OT
    ON O.order_id = OT.order_id
    JOIN stg_products PD 
    ON OT.product_id = PD.product_id
    JOIN cont_headers C
    ON O.order_id = C.order_id
    ORDER BY 2
    
    )

SELECT * FROM renamed_casted

{% if is_incremental() %}

  where date_load  > (select max(date_load ) from {{ this }})

{% endif %}