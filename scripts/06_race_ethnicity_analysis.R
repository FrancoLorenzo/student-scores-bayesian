# 06_race_ethnicity_analysis.R - Bayesian Model: Race/Ethnicity Effect on Scores

# -----------------------------------------------
# 1. Load Packages
# -----------------------------------------------
library(tidyverse)
library(rstanarm)
library(bayesplot)
library(posterior)

# -----------------------------------------------
# 2. Load and Prepare Data
# -----------------------------------------------
df <- read.csv("data/Students-Scores.csv")

df <- df %>%
  rename(
    race_ethnicity = `race.ethnicity`,
    math_score = `math.score`,
    reading_score = `reading.score`,
    writing_score = `writing.score`
  ) %>%
  mutate(race_ethnicity = factor(race_ethnicity, levels = c("group A", "group B", "group C", "group D", "group E")))

# -----------------------------------------------
# 3. Model: Math Score ~ Race/Ethnicity
# -----------------------------------------------
model_math_race <- stan_glm(
  math_score ~ race_ethnicity,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 123
)

save(model_math_race, file = "results/model_summaries/race_math_model.RData")
posterior_math <- as_draws_df(model_math_race)

p_math <- mcmc_areas(
  posterior_math,
  pars = grep("race_ethnicity", colnames(posterior_math), value = TRUE),
  prob = 0.95
) +
  labs(title = "Posterior: Race/Ethnicity Effect on Math Score",
       x = "Estimated Effect vs. Group A")

ggsave("results/figures/posterior_race_math.png", plot = p_math, width = 9, height = 5)

# -----------------------------------------------
# 4. Model: Reading Score ~ Race/Ethnicity
# -----------------------------------------------
model_reading_race <- stan_glm(
  reading_score ~ race_ethnicity,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 123
)

save(model_reading_race, file = "results/model_summaries/race_reading_model.RData")
posterior_reading <- as_draws_df(model_reading_race)

p_reading <- mcmc_areas(
  posterior_reading,
  pars = grep("race_ethnicity", colnames(posterior_reading), value = TRUE),
  prob = 0.95
) +
  labs(title = "Posterior: Race/Ethnicity Effect on Reading Score",
       x = "Estimated Effect vs. Group A")

ggsave("results/figures/posterior_race_reading.png", plot = p_reading, width = 9, height = 5)

# -----------------------------------------------
# 5. Model: Writing Score ~ Race/Ethnicity
# -----------------------------------------------
model_writing_race <- stan_glm(
  writing_score ~ race_ethnicity,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 123
)

save(model_writing_race, file = "results/model_summaries/race_writing_model.RData")
posterior_writing <- as_draws_df(model_writing_race)

p_writing <- mcmc_areas(
  posterior_writing,
  pars = grep("race_ethnicity", colnames(posterior_writing), value = TRUE),
  prob = 0.95
) +
  labs(title = "Posterior: Race/Ethnicity Effect on Writing Score",
       x = "Estimated Effect vs. Group A")

ggsave("results/figures/posterior_race_writing.png", plot = p_writing, width = 9, height = 5)
