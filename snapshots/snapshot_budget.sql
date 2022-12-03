{% snapshot budget_snapshot %}

{{
    config(
      
      unique_key='_row',
      strategy='timestamp',
      updated_at='_fivetran_synced',
      invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_google_sheets_budget') }}

{% endsnapshot %}