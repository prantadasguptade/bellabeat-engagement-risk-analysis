
# Bellabeat Engagement Risk Analysis

> Identifying early behavioural signals of device disengagement 
> using FitBit tracker data to inform Bellabeat's onboarding strategy

**Google Data Analytics Professional Certificate — Capstone Project**  
**Analyst:** Pranta Dasgupta | **Date:** April 2026  
**Tools:** BigQuery · R · Power BI · Advanced Excel  

---

## Business Question

Which behavioural patterns in FitBit users' first 14 days predict 
long-term disengagement, and how should Bellabeat redesign its 
onboarding experience for the Leaf device to reduce churn risk?

---

## Key Findings

- **Medium Risk users show the steepest step decline** — avg steps 
  fell 38.8% from early to late period (8,374 → 5,512), more severe 
  than High Risk users
- **High Risk users show the fastest sleep deterioration** — 7.45% 
  sleep decline rate vs 6.15% for Low Risk, creating a compounding 
  disengagement cycle
- **Low Risk users improved activity by +24.1%** — the only group to 
  increase steps, providing a blueprint for Bellabeat onboarding design
- **9.38% of users are High Risk** — 3 users show critical 
  disengagement signals within the 31-day observation window

---

## Dashboard Preview

### Page 1 — Risk Overview
![Page 1](https://github.com/prantadasguptade/bellabeat-engagement-risk-analysis/blob/69787d89737f845e255919987c113f7abbf86091/Engagement%20Risk%20Overview.PNG)

### Page 2 — Behavioural Patterns
![Page 2](https://github.com/prantadasguptade/bellabeat-engagement-risk-analysis/blob/69787d89737f845e255919987c113f7abbf86091/Behavioural%20Pattern.PNG)

### Page 3 — Risk Profiles & Recommendations
![Page 3](https://github.com/prantadasguptade/bellabeat-engagement-risk-analysis/blob/69787d89737f845e255919987c113f7abbf86091/Risk%20Profiles%20and%20Recommendations.PNG)

---

## Tools & Methodology

| Tool | Purpose |
|------|---------|
| BigQuery SQL | Data cleaning, risk score engineering, aggregations |
| R (ggplot2, tidyverse) | Statistical analysis, 4 visualisation charts |
| Power BI | Interactive 3-page dashboard with slicer |
| Advanced Excel | Data dictionary, cleaning log, findings summary |

---

## Engagement Risk Score — How It Works

The dataset covers 31 days (Apr–May 2016). Since true churn 
cannot be measured in 31 days, I engineered a proxy variable:

| Risk Level | Definition |
|------------|------------|
| High Risk | ≤ 7 days logged in final 14 days |
| Medium Risk | Step decline > 20% from early to late period |
| Low Risk | Consistent logging, stable or improving activity |

---

## Key Recommendations

**Finding 1 — High Priority**  
Medium Risk users decline hardest (−38.8%). Deploy adaptive nudge 
notifications at 600+ sedentary minutes, personalised to each 
user's own baseline step count.

**Finding 2 — High Priority**  
High Risk users show 7.45% sleep decline. Introduce a sleep trend 
alert in the Bellabeat app — trigger when sleep drops >5% over 
7 consecutive days, linking sleep loss to predicted activity decline.

**Finding 3 — Medium Priority**  
Low Risk users improved +24.1%. Reverse-engineer their behaviour 
patterns (consistent logging, steady activity) into Bellabeat's 
new user onboarding flow from Day 1.

---

## Repository Structure 
---

## Data Source

FitBit Fitness Tracker Data — Kaggle (CC0 Public Domain)  
[https://www.kaggle.com/datasets/arashnic/fitbit](https://www.kaggle.com/datasets/arashnic/fitbit)  
33 users · 31 days · Apr–May 2016

---

## Limitations

- Small sample size (n=32 users) — findings are directional, 
  not statistically definitive
- Data from 2016 — wearable behaviour has evolved; findings 
  supplemented with current industry benchmarks
- No gender metadata — analysed as proxy for Bellabeat's 
  female-focused product line
- 31-day window only — proxy disengagement variable used 
  instead of true long-term churn

---

*Pranta Dasgupta | [LinkedIn](https://www.linkedin.com/in/prantadasgupta/) 
| [GitHub](https://github.com/prantadasguptade)*  
