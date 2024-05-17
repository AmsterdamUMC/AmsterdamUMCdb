SELECT (CAST((
SELECT round(
  CAST(sum(CASE
    WHEN (
      d.start <= {msfromdate}
      AND d.stop >= {mstodate}
      AND d.fluidin <> 0
    ) THEN ((({mstodate} - {msfromdate}) / ((d.duration * 1000) * 60)) * d.fluidin)
    WHEN (
      d.start < {msfromdate}
      AND d.stop > {msfromdate}
      AND d.stop <= {mstodate}
      AND d.fluidin <> 0
    ) THEN (((d.stop - {msfromdate}) / ((d.duration * 1000) * 60)) * d.fluidin)
    WHEN (
      d.start >= {msfromdate}
      AND d.start < {mstodate}
      AND d.stop > {msfromdate}
      AND d.stop <= {mstodate}
      AND d.fluidin <> 0
    ) THEN CASE
      WHEN (
        d.rate = 0
        AND d.dose <> 0
        AND d.solutionadministered <> 0
        AND d.duration = 1
      ) THEN round(
        CAST(d.solutionadministered AS NUMERIC),
        1
      )
      ELSE d.fluidin
    END
    WHEN (
      d.start >= {msfromdate}
      AND d.start < {mstodate}
      AND d.stop > {mstodate}
      AND d.fluidin <> 0
    ) THEN ((({mstodate} - d.start) / ((d.duration * 1000) * 60)) * d.fluidin)
  END) AS NUMERIC),
  0
) AS fluidin
FROM drugitems AS d
WHERE d.admissionid = {admissionid}
) - (
SELECT round(CAST(
  sum(num.fluidout)AS NUMERIC),
  0
)
FROM numericitems AS num
WHERE (
  num.admissionid = {admissionid}
  AND num.fluidout <> 0
  AND num.fluidout IS NOT NULL
  AND num.measuredat >= {msfromdate}
  AND num.measuredat < {mstodate}
)
)AS NUMERIC)) AS fluidbalance