WITH user_periods AS (
  SELECT
    Id,
    ActivityDate,

    SAFE_CAST(TotalSteps AS INT64) AS TotalSteps,
    SAFE_CAST(SedentaryMinutes AS INT64) AS SedentaryMinutes,

    CASE
      WHEN ActivityDate <= DATE '2016-04-26' THEN 'early'
      ELSE 'late'
    END AS period

  FROM fitbit_data.daily_activity
),

user_metrics AS (
  SELECT
    Id,
    period,
    COUNT(*) AS days_logged,
    AVG(TotalSteps) AS avg_steps,
    AVG(SedentaryMinutes) AS avg_sedentary
  FROM user_periods
  GROUP BY Id, period
),

early AS (
  SELECT Id,
    days_logged AS early_days,
    avg_steps   AS early_steps
  FROM user_metrics 
  WHERE period = 'early'
),

late AS (
  SELECT Id,
    days_logged AS late_days,
    avg_steps   AS late_steps,
    avg_sedentary AS avg_sedentary_late
  FROM user_metrics 
  WHERE period = 'late'
),

combined AS (
  SELECT
    e.Id,
    e.early_days,
    l.late_days,

    ROUND(e.early_steps, 1) AS early_steps,
    ROUND(l.late_steps,  1) AS late_steps,

    ROUND(l.avg_sedentary_late, 1) AS avg_sedentary_mins,

    ROUND(
      SAFE_DIVIDE(e.early_steps - l.late_steps, e.early_steps) * 100,
    1) AS step_decline_pct

  FROM early e
  JOIN late l ON e.Id = l.Id

  WHERE e.early_days >= 3 
    AND l.late_days >= 3
)

SELECT *,
  CASE
    WHEN late_days <= 7 THEN 'High Risk'
    WHEN step_decline_pct > 20 THEN 'Medium Risk'
    ELSE 'Low Risk'
  END AS engagement_risk

FROM combined
ORDER BY late_days ASC;
