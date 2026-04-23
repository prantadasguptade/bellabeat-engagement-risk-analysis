install.packages(c("tidyverse","ggplot2","lubridate","scales","readr"))
library(tidyverse)
library(ggplot2)
library(lubridate)
library(scales)

# Load files (set your working directory first)
daily  <- read_csv("DailyActivityMergedClean.csv")
sleep  <- read_csv("SleepDay.csv")
risk   <- read_csv("Risk_Score_Table_Final.csv")  # exported from BigQuery

# Clean dates
daily <- daily %>%
  mutate(ActivityDate = mdy(ActivityDate)) 

#Chart1
risk %>%
  count(engagement_risk) %>%
  ggplot(aes(x=reorder(engagement_risk,-n), y=n, fill=engagement_risk)) +
  geom_col(width=0.6) +
  scale_fill_manual(values=c("High Risk"="#D85A30","Medium Risk"="#EF9F27","Low Risk"="#1D9E75")) +
  labs(title="User Engagement Risk Distribution",
       subtitle="Based on activity logging patterns in final 14 days",
       x="Risk Level", y="Number of Users") +
  theme_minimal() + theme(legend.position="none")

ggsave("chart1_risk_distribution.png", width=7, height=5, dpi=150) 

#Chart2 
risk %>%
  pivot_longer(cols=c(early_steps, late_steps),
               names_to="period", values_to="avg_steps") %>%
  mutate(period = ifelse(period=="early_steps","First 14 days","Last 14 days")) %>%
  ggplot(aes(x=engagement_risk, y=avg_steps, fill=period)) +
  geom_col(position="dodge", width=0.6) +
  scale_fill_manual(values=c("First 14 days"="#378ADD","Last 14 days"="#D85A30")) +
  labs(title="Step Count Decline by Risk Group",
       subtitle="Comparing early vs late period activity",
       x="Risk Level", y="Avg Daily Steps", fill="Period") +
  theme_minimal()

ggsave("chart2_step_decline.png", width=8, height=5, dpi=150)



#Chart3
daily %>%
  mutate(day = wday(ActivityDate, label=TRUE, abbr=FALSE)) %>%
  group_by(day) %>%
  summarise(avg_steps = mean(TotalSteps, na.rm=TRUE),
            avg_sedentary = mean(SedentaryMinutes, na.rm=TRUE)) %>%
  ggplot(aes(x=day, y=avg_steps)) +
  geom_col(fill="#378ADD", width=0.6) +
  geom_text(aes(label=comma(round(avg_steps,0))), vjust=-0.5, size=3.5) +
  labs(title="Average Daily Steps by Day of Week",
       x=NULL, y="Avg Steps") +
  theme_minimal()

ggsave("chart3_day_of_week.png", width=8, height=5, dpi=150)


#Chart5

sleep_clean <- sleep %>%
  mutate(SleepDate = mdy_hms(SleepDay),
         sleep_hrs = TotalMinutesAsleep/60)

left_join(sleep_clean, risk, by="Id") %>%
  filter(!is.na(engagement_risk)) %>%
  ggplot(aes(x=engagement_risk, y=sleep_hrs, fill=engagement_risk)) +
  geom_boxplot(alpha=0.7, outlier.shape=21) +
  scale_fill_manual(values=c("High Risk"="#D85A30","Medium Risk"="#EF9F27","Low Risk"="#1D9E75")) +
  labs(title="Sleep Duration by Engagement Risk Group",
       x="Risk Level", y="Hours of Sleep", fill="Risk") +
  theme_minimal()

ggsave("chart4_sleep_risk.png", width=7, height=5, dpi=150)