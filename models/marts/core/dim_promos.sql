with stg_promos as (
    SELECT * 
    FROM {{ref('stg_sql_server_dbo_promos')}}
),


renamed_cast as(
    
    SELECT
          promo_id
        , promo_name
        , status
        , discount
        , data_removed
        , date_load

    FROM stg_promos

)

SELECT * FROM renamed_cast