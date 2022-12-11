-- cantidad de productos vendidos e importe total para cada dia por producto --

with fct_orders AS (
    SELECT * 
    FROM {{ref('fct_orders_products')}}
),

dim_products AS (
    SELECT * 
    FROM {{ref('dim_products')}}
),

dim_tiempo AS(
    SELECT *
    FROM {{ref('dim_tiempo_dia')}}
),


sales_per_day AS(
    SELECT
        date_id
        ,P.product_id
        ,P.name
        ,count(P.product_id) QUANTITY_SOLD
        ,sum(order_header_cost) SALES

    FROM fct_orders O
    JOIN dim_tiempo T 
    ON O.created_at = T.date_id
    JOIN dim_products P
    ON O.product_id = P.product_id
    GROUP BY 1,2,3
    ORDER BY 1,3
)

SELECT * FROM sales_per_day