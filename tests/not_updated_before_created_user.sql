SELECT *
FROM {{ref('stg_sql_server_dbo_users')}}
WHERE created_at > updated_at