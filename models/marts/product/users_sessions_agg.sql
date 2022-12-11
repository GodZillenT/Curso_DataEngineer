{% set event_types = obtener_valores(ref('stg_sql_server_dbo_events'), 'event_type') %}

with events as (
    SELECT *
    FROM {{ ref('int_events_type')}}
),

dim_users as (
    SELECT *
    FROM {{ref('dim_users')}}
),

usuario_sesion as(
    SELECT
       distinct session_id,
       U.user_id,
       first_name,
       email,
       min(E.created_at) as first_event_time_utc,
       max(E.created_at) as last_event_time_utc,
       DATEDIFF('minute',first_event_time_utc,last_event_time_utc) as session_length_minutes,
       {%- for event_type in event_types   %}
        sum(case when E.event_type = '{{event_type}}' then 1 end) as {{event_type}}_amount
        {%- if not loop.last %},{% endif -%}
        {% endfor %} 
       FROM dim_users U
       JOIN events E
       ON U.user_id = E.user_id
       {{dbt_utils.group_by(4)}}
       
)

SELECT * FROM usuario_sesion

