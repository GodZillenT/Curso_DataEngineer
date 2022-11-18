WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),


renamed_casted AS (
    SELECT
          md5(promo_id)
        , promo_id as promo_name
        , discount
        , status
        , _fivetran_deleted AS data_removed
        , _fivetran_synced AS date_load
    FROM src_promos
    )

SELECT * FROM renamed_casted
