with int_tiempo_budget AS (
    SELECT * 
    FROM {{ref('int_budget_tiempo_details')}}
),

fct_orders AS(
    SELECT *
    FROM {{ref('fct_orders_products')}}
),

dim_products AS(
    SELECT *
    FROM {{ref('dim_products')}}
),

monthly_budget AS(
    
    SELECT
        mes
        ,P.product_id 
        ,P.name
        ,T.quantity as SALES_TARGET
        ,count(O.product_id) as SALES
    FROM fct_orders O
    JOIN dim_products P
    ON O.product_id = P.product_id
    LEFT JOIN int_tiempo_budget T
    ON T.product_id = P.product_id

    {{dbt_utils.group_by(4)}}

)


SELECT * FROM monthly_budget