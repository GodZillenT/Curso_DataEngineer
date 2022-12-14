with source as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

renamed as (

    select
        address_id,
        address,
        zipcode,
        country,
        state,
        _fivetran_deleted as data_removed,
        _fivetran_synced as date_load

    from source

)

select * from renamed 