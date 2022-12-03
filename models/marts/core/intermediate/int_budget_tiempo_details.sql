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
         _row
        , product_id
        , date_id
        , anio
        , mes
        , desc_mes
        , semana
        , semestre
        , cuatrimestre
        , quantity 
        , date_load
    FROM fct_budget B
    JOIN dim_tiempo_mes T
    ON B.date_id = T.id_anio_mes
)

SELECT * FROM renamed_casted
