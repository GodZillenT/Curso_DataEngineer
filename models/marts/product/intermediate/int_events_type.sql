with fct_events as (
    SELECT *
    FROM {{ref('fct_events')}}
),

dim_event_type as (
    SELECT *
    FROM {{ ref('dim_event_type')}}
),


events_with_type as (
    SELECT 
        E.event_id,
        E.user_id,
        E.session_id,
        E.page_url,
        E.type_event_id,
        E.created_at,
        ET.event_type

    FROM fct_events E
    JOIN dim_event_type ET 
    ON E.type_event_id = ET.type_event_id
    {{dbt_utils.group_by(7) }}
       

)

SELECT * FROM events_with_type