with fct_orders_products as (
    SELECT *
    FROM {{ref('fct_orders_products')}}
),

dim_users as (
    SELECT *
    FROM {{ref('dim_users')}}
),

dim_addresses as (
    SELECT *
    FROM {{ref('dim_addresses')}}
),
dim_promos as (
    SELECT *
    FROM {{ref('dim_promos')}}
),


usuario_orders as(
    
    SELECT
        U.user_id
        ,U.first_name
        ,U.last_name
        ,U.email
        ,U.phone_number
        ,U.created_at
        ,U.updated_at
        ,(DATEDIFF('day',U.created_at, U.updated_at)) as DAYS_TO_UPDATE
        ,A.address
        ,A.zipcode
        ,A.state
        ,A.country
        ,COUNT(order_id) as TOTAL_NUMBER_ORDERS
        ,SUM(order_total) as TOTAL_ORDER_COST_USD
        ,SUM(shipping_cost) as TOTAL_SHIPPING_COST_USD
        ,SUM(P.discount) as TOTAL_DISCOUNT_USD
        ,SUM(quantity) as TOTAL_QUANTITY_PRODUCT
        ,COUNT(distinct product_id) as TOTAL_DIFFERENT_PRODUCTS
        FROM dim_users U
        JOIN fct_orders_products O
        ON  U.user_id = O.user_id
        JOIN dim_addresses A
        ON O.address_id = A.address_id
        JOIN dim_promos P
        ON O.promo_id = P.promo_id
       
       {{dbt_utils.group_by(7)}},9,10,11,12
       ORDER BY 2 ASC
       
)


SELECT * FROM usuario_orders

