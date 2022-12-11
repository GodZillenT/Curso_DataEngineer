WITH fct_orders_products AS (
    SELECT * 
    FROM {{ ref('fct_orders_products') }}
),

dim_tiempo_dia AS(
    SELECT *
    FROM {{ ref('dim_tiempo_dia')}}
),


renamed_casted as(
    select
        order_id,
        user_id,
        promo_id
        address_id,
        created_at,
        anio,
        mes,
        desc_mes,
        dia,
        dia_semana,
        shipping_cost,
        order_cost,
        order_total,
        status_order,
        tracking_id,
        shipping_service,
        delivered_at
    FROM fct_orders_products O
    JOIN dim_tiempo_dia T
    ON O.CREATED_AT = T.date_id
)

SELECT * FROM renamed_casted

