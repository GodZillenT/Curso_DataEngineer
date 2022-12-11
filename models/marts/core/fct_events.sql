{{ config(
    materialized='incremental',
    unique_key = 'event_id'
    ) 
    }}


WITH stg_events AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo_events') }}
),


renamed_casted AS (
    SELECT
        event_id,
        user_id,
        product_id,
        session_id,
        md5(event_type) as type_event_id,
        page_url,  
        created_at,
        data_removed,
        date_load
        
    FROM stg_events
    )

SELECT * FROM renamed_casted


{% if is_incremental() %}

  where date_load  > (select max(date_load ) from {{ this }})

{% endif %}