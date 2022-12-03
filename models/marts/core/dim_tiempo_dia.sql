{{ 
    config(
        materialized='table', 
        sort='date_day',
        dist='date_day',
        pre_hook="alter session set timezone = 'Europe/Madrid'; alter session set week_start = 7;" 
        ) }}

with date as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2000-01-01' as date)",
        end_date="cast(current_date()+1 as date)"
    )
    }}  
)


select
      date_day as date_id
    , year(date_day)*10000+month(date_day)*100+day(date_day) as id_date
    , year(date_day) as anio
    , month(date_day) as mes
    ,monthname(date_day) as desc_mes
    , DAY(date_day) as dia
    , case when dayofweek(date_day) = 1 then 'Monday'
           when dayofweek(date_day) = 2 then 'Tuesday'
           when dayofweek(date_day) = 3 then 'Wednesday'
           when dayofweek(date_day) = 4 then 'Thursday'
           when dayofweek(date_day) = 5 then 'Friday'
           when dayofweek(date_day) = 6 then 'Saturday'
       else 'Sunday'
       end as dia_semana
    , date_day-1 as dia_previo
    , year(date_day)||weekiso(date_day)||dayofweek(date_day) as anio_semana_dia
    , weekiso(date_day) as semana
    , case when mes < 7 then 1
      else 2
      end as semestre
    , case when mes between 1 and 4 then 1
           when mes between 5 and 8 then 2
      else 3
      end as cuatrimestre
from date
order by
    date_day desc