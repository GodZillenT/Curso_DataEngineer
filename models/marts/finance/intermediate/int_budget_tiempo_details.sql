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
        , id_anio_mes_budget
        , anio
        , mes
        , desc_mes
        , semana
        , semestre
        , cuatrimestre
        , quantity 
        , _fivetran_synced
    FROM fct_budget B
    JOIN dim_tiempo_mes T
    ON B.id_anio_mes_budget = T.id_anio_mes
)

SELECT * FROM renamed_casted
