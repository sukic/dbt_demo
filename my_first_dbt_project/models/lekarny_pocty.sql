WITH buffers AS (
  SELECT
        id_lekarny,
        St_buffer(geom::geography,500)::geometry AS geom

    from {{ source('dbt_src', 'lekarny') }}
)

,pocty AS (
  SELECT
    a.id_lekarny
    ,count(1) AS pocet
  FROM
    buffers a
    LEFT JOIN lekarny b ON St_Intersects(a.geom,b.geom)
  GROUP BY
    a.id_lekarny
)

SELECT
  a.*
  ,b.pocet
FROM
  {{ source('dbt_src','lekarny') }} a
  LEFT JOIN pocty b ON a.id_lekarny = b.id_lekarny
