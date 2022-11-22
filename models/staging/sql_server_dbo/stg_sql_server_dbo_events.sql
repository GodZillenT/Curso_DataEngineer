with source as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed as (

    select
        event_id,
        user_id,
        product_id,
        session_id,
        event_type,
        page_url,  
        created_at,
        _fivetran_deleted as data_removed,
        _fivetran_synced as date_load

    from source

)

select * from renamed