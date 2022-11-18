with source as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

renamed as (

    select
        user_id,
        last_name,
        phone_number,
        updated_at,
        address_id,
        created_at,
        first_name,
        total_orders,
        email,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed