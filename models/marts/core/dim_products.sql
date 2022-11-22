with stg_products as (
    SELECT * 
    FROM {{ref('stg_sql_server_dbo_products')}}
),


renamed_cast as(
    
    select
        product_id,
        name,
        price_usd,
        inventory,
        data_remove,
        date_load

    FROM stg_products

)

SELECT * FROM renamed_cast