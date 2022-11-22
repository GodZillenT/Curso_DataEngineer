with source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        order_id,
        user_id,
        address_id,
        tracking_id,
        status as status_order,
        case when promo_id = '' then md5('')
        else md5(promo_id)
        end as promo_id,
        created_at,
        delivered_at,
        estimated_delivery_at,
        shipping_service,
        shipping_cost::numeric(6,2) as shipping_cost,
        order_cost::numeric(6,2) as order_cost,
        order_total::numeric(6,2) as order_total, 
        _fivetran_deleted as data_removed,
        _fivetran_synced as date_load

    from source

)

select * from renamed 