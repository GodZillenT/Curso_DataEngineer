# 18. Ejercicios prácticos

1. ¿Cuántos usuarios tenemos?

with stg_users as (
    SELECT * 
    FROM {{ref('stg_sql_server_dbo_users')}}
),


num_users as(
    
    SELECT
       distinct count(user_id) as numero_usuarios
    
    FROM stg_users

)

SELECT * FROM num_users

## Resultado --> 130.


2. En promedio, ¿cuánto tiempo tarda un pedido desde que se realiza hasta que se entrega?

SELECT  AVG(datediff(day,created_at,delivered_at)) from stg_sql_server_dbo_orders;

###Resultado --> AVG(DATEDIFF(DAY,CREATED_AT,DELIVERED_AT))
3.891803

3. ¿Cuántos usuarios han realizado una sola compra? ¿Dos compras? ¿Tres o más compras?

with stg_orders as (
    SELECT *
    FROM {{ref('stg_sql_server_dbo_orders')}}
),


num_compras as(
    
    SELECT
       user_id, count(distinct order_id) as num_compras
       FROM stg_orders
       GROUP BY 1

),

grouped_users as(

    SELECT
        CASE
            WHEN num_compras =1 THEN '1'
            WHEN num_compras =2 THEN '2'
            ELSE '3+'
            END AS num_compras,
            COUNT(DISTINCT user_id ) AS USERS
    FROM NUM_COMPRAS
    GROUP BY 1
    ORDER BY 1

        


)

SELECT * FROM grouped_users

NUM_COMPRAS_USERS
1       25
2       28
3+      71



- En promedio, ¿Cuántas sesiones únicas tenemos por hora?


with stg_events as (
    SELECT *
    FROM {{ref('stg_sql_server_dbo_events')}}
),


sesiones_hora as(
    
    SELECT
       HOUR(created_at) AS HORAS, COUNT(distinct SESSION_ID) as numero
       FROM stg_events
       GROUP BY HORAS
       ORDER BY HORAS

),

promedio as(
    SELECT AVG(NUMERO) AS promedio
    FROM sesiones_hora
)




SELECT * FROM PROMEDIO

### Resultado --> PROMEDIO
16.916667


18.1 Caso de Uso para el equipo de Producto


