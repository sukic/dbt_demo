{{
  config(
    materialized='view'
  )
}}

SELECT
  a.kod_zsj_d
  ,a.pocet
  ,b.kod AS kod_zsj
  ,b.nazev
  ,b.vymera
FROM
  {{ ref('lekarny_zsjd') }} AS a
  LEFT JOIN {{ source('dbt_src','zsj') }} AS b
    ON LEFT(a.kod_zsj_d,6) = b.kod::VARCHAR
