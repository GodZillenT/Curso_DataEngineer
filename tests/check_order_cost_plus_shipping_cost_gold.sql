SELECT *
FROM {{ ref('stg_sql_server_dbo_orders') }}
WHERE delivered_at < created_at
/* comprueba si la suma de shipping cost y order cost da como resultado order_total, para cada linea de pedido