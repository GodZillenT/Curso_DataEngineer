{{ 
    config(
        materialized='table', 
        sort='date_month',
        dist='date_month',
        pre_hook="alter session set timezone = 'Europe/Madrid'; alter session set week_start = 7;" 
        ) }}

with date as (
    {{ dbt_utils.date_spine(
        datepart="month",
        start_date="cast('2000-01-01' as date)",
        end_date="cast(current_date()+1 as date)"
    )
    }}  
)


select

      year(date_month)*100+month(date_month) as id_anio_mes
    , weekiso(date_month) as semana
    , year(date_month) as anio
    , month(date_month) as mes
    ,monthname(date_month) as desc_mes
    , case when mes < 7 then 1
      else 2
      end as semestre
    , case when mes between 1 and 4 then 1
           when mes between 5 and 8 then 2
      else 3
      end as cuatrimestre
  
from date
order by
    date_month desc