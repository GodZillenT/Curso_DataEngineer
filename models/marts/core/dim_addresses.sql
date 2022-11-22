with stg_addresses as (
    SELECT * 
    FROM {{ref('stg_sql_server_dbo_addresses')}}
),


renamed_cast as(
    
    select
        address_id,
        address,
        zipcode,
        country,
        state,
        data_removed,
        date_load

    from stg_addresses

)

SELECT * FROM renamed_cast