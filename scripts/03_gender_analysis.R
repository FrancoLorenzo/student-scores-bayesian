# 03_gender_analysis.R - Bayesian Model: Gender Effect on Student Scores

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
    gender = gender,
    math_score = `math.score`,
    reading_score = `reading.score`,
    writing_score = `writing.score`
  ) %>%
  mutate(gender = factor(gender, levels = c("female", "male")))  # Female is baseline

# -----------------------------------------------
# 3. Model: Math Score ~ Gender
# -----------------------------------------------
model_math_gender <- stan_glm(
  math_score ~ gender,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 123
)

save(model_math_gender, file = "results/model_summaries/gender_math_model.RData")
posterior_math <- as_draws_df(model_math_gender)
prob_math <- mean(posterior_math$gendermale > 0)
cat("Probability that males score higher in math than females:", round(prob_math, 3), "\n")

p_math <- mcmc_areas(
  posterior_math,
  pars = "gendermale",
  prob = 0.95
) +
  labs(title = "Posterior: Effect of Gender on Math Score",
       x = "Estimated Effect (points)")

ggsave("results/figures/posterior_gender_math.png", plot = p_math, width = 8, height = 4)

# -----------------------------------------------
# 4. Model: Reading Score ~ Gender
# -----------------------------------------------
model_reading_gender <- stan_glm(
  reading_score ~ gender,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 123
)

save(model_reading_gender, file = "results/model_summaries/gender_reading_model.RData")
posterior_reading <- as_draws_df(model_reading_gender)
prob_reading <- mean(posterior_reading$gendermale > 0)
cat("Probability that males score higher in reading than females:", round(prob_reading, 3), "\n")

p_reading <- mcmc_areas(
  posterior_reading,
  pars = "gendermale",
  prob = 0.95
) +
  labs(title = "Posterior: Effect of Gender on Reading Score",
       x = "Estimated Effect (points)")

ggsave("results/figures/posterior_gender_reading.png", plot = p_reading, width = 8, height = 4)

# -----------------------------------------------
# 5. Model: Writing Score ~ Gender
# -----------------------------------------------
model_writing_gender <- stan_glm(
  writing_score ~ gender,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 123
)

save(model_writing_gender, file = "results/model_summaries/gender_writing_model.RData")
posterior_writing <- as_draws_df(model_writing_gender)
prob_writing <- mean(posterior_writing$gendermale > 0)
cat("Probability that males score higher in writing than females:", round(prob_writing, 3), "\n")

p_writing <- mcmc_areas(
  posterior_writing,
  pars = "gendermale",
  prob = 0.95
) +
  labs(title = "Posterior: Effect of Gender on Writing Score",
       x = "Estimated Effect (points)")

ggsave("results/figures/posterior_gender_writing.png", plot = p_writing, width = 8, height = 4)
