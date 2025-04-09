# 01_eda.R - Exploratory Data Analysis for Student Scores

# -----------------------------------------------
# 1. Load Packages
# -----------------------------------------------
library(tidyverse)
library(ggplot2)

# Create folder for figures if it doesn’t exist
if (!dir.exists("results/figures")) dir.create("results/figures", recursive = TRUE)

# -----------------------------------------------
# 2. Load and Clean Data
# -----------------------------------------------
df <- read.csv("data/Students-Scores.csv")

df <- df %>%
  rename(
    gender = gender,
    race_ethnicity = `race.ethnicity`,
    parental_education = `parental.level.of.education`,
    lunch = lunch,
    test_prep = `test.preparation.course`,
    math_score = `math.score`,
    reading_score = `reading.score`,
    writing_score = `writing.score`
  )

# -----------------------------------------------
# 3. Basic Summary
# -----------------------------------------------
summary(df)
glimpse(df)

# -----------------------------------------------
# 4. Score Distributions
# -----------------------------------------------
score_long <- df %>%
  pivot_longer(cols = c(math_score, reading_score, writing_score), 
               names_to = "subject", values_to = "score")

p1 <- ggplot(score_long, aes(x = score, fill = subject)) +
  geom_histogram(bins = 30, alpha = 0.6, position = "identity") +
  facet_wrap(~ subject, scales = "free") +
  labs(title = "Score Distributions by Subject", x = "Score", y = "Count") +
  theme_minimal()

ggsave("results/figures/eda_score_distributions.png", plot = p1, width = 10, height = 5)

# -----------------------------------------------
# 5. Scores by Gender
# -----------------------------------------------
p2 <- ggplot(score_long, aes(x = gender, y = score, fill = gender)) +
  geom_boxplot(alpha = 0.7) +
  facet_wrap(~ subject) +
  labs(title = "Scores by Gender", x = "Gender", y = "Score") +
  theme_minimal()

ggsave("results/figures/eda_scores_by_gender.png", plot = p2, width = 10, height = 5)

# -----------------------------------------------
# 6. Scores by Test Preparation
# -----------------------------------------------
p3 <- ggplot(score_long, aes(x = test_prep, y = score, fill = test_prep)) +
  geom_boxplot(alpha = 0.7) +
  facet_wrap(~ subject) +
  labs(title = "Scores by Test Preparation Status", x = "Test Preparation", y = "Score") +
  theme_minimal()

ggsave("results/figures/eda_scores_by_test_prep.png", plot = p3, width = 10, height = 5)

# -----------------------------------------------
# 7. Scores by Parental Education
# -----------------------------------------------
p4 <- ggplot(score_long, aes(x = reorder(parental_education, score, median), y = score, fill = parental_education)) +
  geom_boxplot(alpha = 0.8) +
  facet_wrap(~ subject) +
  coord_flip() +
  labs(title = "Scores by Parental Level of Education", x = "Parental Education", y = "Score") +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("results/figures/eda_scores_by_parent_edu.png", plot = p4, width = 12, height = 6)
