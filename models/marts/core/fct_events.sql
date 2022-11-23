
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
        event_type,
        page_url,  
        created_at,
        data_removed,
        date_load
        
    FROM stg_events
    )

SELECT * FROM renamed_casted