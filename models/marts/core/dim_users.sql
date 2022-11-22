with stg_users as (
    SELECT * 
    FROM {{ref('stg_sql_server_dbo_users')}}
),


renamed_cast as(
    
    SELECT
        user_id
        , first_name
        , last_name
        , email
        , phone_number
        , address_id
        , created_at
        , updated_at
        , date_load
    FROM stg_users

)

SELECT * FROM renamed_cast


