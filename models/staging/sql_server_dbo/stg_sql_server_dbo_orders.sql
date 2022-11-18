with source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        order_id,
        user_id,
        case when promo_id = '' then md5('')
        else md5(promo_id)
        end as promo_id,
        address_id,
        tracking_id,
        status,
        CAST(date_trunc('day', created_at) AS DATE) as created_at,
        delivered_at,
        estimated_delivery_at,
        shipping_cost,
        order_cost,
        order_total, 
        shipping_service,
        _fivetran_deleted as data_removed,
        _fivetran_synced as date_load

    from source

)

select * from renamed