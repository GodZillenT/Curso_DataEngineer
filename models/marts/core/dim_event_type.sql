
WITH stg_events AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo_events') }}
),


renamed_casted AS (
    SELECT
        distinct md5(event_type) as type_event_id,
        event_type

    FROM stg_events
    )

SELECT * FROM renamed_casted