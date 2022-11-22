WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),


renamed_casted AS (
    SELECT
        md5(promo_id) as promo_id
        , promo_id as promo_name
        , status
        , discount
        , _fivetran_deleted AS data_removed
        , _fivetran_synced AS date_load
    FROM src_promos
    )

SELECT * FROM renamed_casted
UNION ALL
SELECT 

    md5('') as promo_id,  
    'none_promo' as promo_name,
    'inactive' as status,
    0  as discount,
    'false' as data_removed,
    sysdate() as data_load
