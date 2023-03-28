{{
  config(
    materialized='view'
  )
}}

SELECT
  kod_zsj_d
  ,sum(pocet) AS pocet
FROM
  {{ ref('lekarny_pocty') }}
GROUP BY
  kod_zsj_d
