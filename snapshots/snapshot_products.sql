{% snapshot product_snapshot %}

{{
    config(
      materialized='table',
      unique_key='product_id',
      strategy='timestamp',
      updated_at='date_load',
      invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_sql_server_dbo_products') }}

{% endsnapshot %}