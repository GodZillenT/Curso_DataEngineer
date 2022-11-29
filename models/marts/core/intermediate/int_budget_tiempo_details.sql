WITH fct_budget AS (
    SELECT * 
    FROM {{ ref('fct_budget') }}
),

dim_tiempo_mes AS(
    SELECT *
    FROM {{ ref('dim_tiempo_mes')}}
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
    FROM fct_budget B
    JOIN dim_tiempo_mes T
    ON B.CREATED_AT = T.ID_FECHA
)

SELECT * FROM renamed_casted
