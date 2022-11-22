with source as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

renamed as (

    select
        user_id,
        first_name,
        last_name,
        address_id,
        phone_number,
        email,
        CAST(date_trunc('day', created_at) AS DATE) as created_at,
        CAST(date_trunc('day', updated_at) AS DATE) as updated_at,
        _fivetran_deleted as data_removed,
        _fivetran_synced as date_load

    from source

)

select * from renamed