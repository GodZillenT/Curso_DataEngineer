with source as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed as (

    select
        event_id,
        product_id,
        session_id,
        event_type,
        page_url,
        order_id,
        user_id,
        created_at,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed