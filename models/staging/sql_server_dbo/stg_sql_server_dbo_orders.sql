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
        CAST(date_trunc('day', created_at) AS DATE) as created_at,
        CAST(date_trunc('day', delivered_at) AS DATE) as delivered_at,
        CAST(date_trunc('day', estimated_delivery_at) AS DATE) as estimated_delivery_at,
        shipping_service,
        shipping_cost::numeric(6,2) as shipping_cost,
        order_cost::numeric(6,2) as order_cost,
        order_total::numeric(6,2) as order_total, 
        _fivetran_deleted as data_removed,
        _fivetran_synced as date_load

    from source

)

select * from renamed 