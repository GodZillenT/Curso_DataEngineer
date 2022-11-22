with source as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

renamed as (

    select
        product_id,
        name,
        price as price_usd,
        inventory,
        _fivetran_deleted as data_remove,
        _fivetran_synced as date_load

    from source

)

select * from renamed