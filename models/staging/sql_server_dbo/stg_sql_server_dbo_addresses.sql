with source as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

renamed as (

    select
        address_id,
        zipcode,
        address,
        country,
        state,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed