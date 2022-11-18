with source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        order_id,
        user_id,
        shipping_cost,
        status,
        delivered_at,
        address_id,
        created_at,
        estimated_delivery_at,
        order_cost,
        tracking_id,
        promo_id,
        shipping_service,
        order_total,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed