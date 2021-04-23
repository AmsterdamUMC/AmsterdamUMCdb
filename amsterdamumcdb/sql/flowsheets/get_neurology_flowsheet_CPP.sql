SELECT
  icp.admissionid,
  icp.measuredat,
  icp.itemid AS icp_itemid,
  icp.value AS icp,
  abpm.itemid AS abpm_itemid,
  round(
    CAST(abpm.value AS numeric),
    0
  ) AS abpm,
  (round(
    CAST(abpm.value AS numeric),
    0
  ) - round(
    CAST(icp.value AS numeric),
    0
  )) AS cpp
FROM numericitems AS icp
  JOIN numericitems AS abpm
    ON (
      icp.admissionid = abpm.admissionid
      AND icp.measuredat = abpm.measuredat
    )
WHERE (
  icp.itemid IN (
    8835, 19358
  )
  AND abpm.itemid = 6642
)
UNION
SELECT
  icp.admissionid,
  icp.measuredat,
  icp.itemid,
  icp.value,
  abpm.itemid,
  round(
    CAST(abpm.value AS numeric),
    0
  ),
  (round(
    CAST(abpm.value AS numeric),
    0
  ) - round(
    CAST(icp.value AS numeric),
    0
  ))
FROM numericitems AS icp
  JOIN numericitems AS abpm
    ON (
      icp.admissionid = abpm.admissionid
      AND icp.measuredat = abpm.measuredat
    )
WHERE (
  icp.itemid = 13940
  AND abpm.itemid = 6642
)