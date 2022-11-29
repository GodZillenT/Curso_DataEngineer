

with fct_events as (
    SELECT *
    FROM {{ref('fct_events')}}
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
       {{column_values_to_metrics(ref('stg_sql_server_dbo_events'),'event_type')}}
       FROM dim_users U
       JOIN fct_events E 
       ON U.user_id = E.user_id
       {{dbt_utils.group_by(4) }}
       
)


SELECT * FROM usuario_sesion

