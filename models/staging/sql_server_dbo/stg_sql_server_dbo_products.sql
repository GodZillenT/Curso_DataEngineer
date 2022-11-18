with source as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

renamed as (

    select
        product_id,
        inventory,
        name,
        price,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed