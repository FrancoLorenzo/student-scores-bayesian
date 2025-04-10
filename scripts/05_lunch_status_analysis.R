# 05_lunch_status_analysis.R - Bayesian Model: Lunch Status Effect on Scores

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
    lunch = lunch,
    math_score = `math.score`,
    reading_score = `reading.score`,
    writing_score = `writing.score`
  ) %>%
  mutate(lunch = factor(lunch, levels = c("free/reduced", "standard")))  # Reference: free/reduced

# -----------------------------------------------
# 3. Model: Math Score ~ Lunch
# -----------------------------------------------
model_math_lunch <- stan_glm(
  math_score ~ lunch,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 123
)

save(model_math_lunch, file = "results/model_summaries/lunch_math_model.RData")
posterior_math <- as_draws_df(model_math_lunch)
prob_math <- mean(posterior_math$lunchstandard > 0)
cat("Probability that standard lunch students score higher in math:", round(prob_math, 3), "\n")

p_math <- mcmc_areas(
  posterior_math,
  pars = "lunchstandard",
  prob = 0.95
) +
  labs(title = "Posterior: Lunch Status Effect on Math Score",
       x = "Estimated Effect (points)")

ggsave("results/figures/posterior_lunch_math.png", plot = p_math, width = 8, height = 4)

# -----------------------------------------------
# 4. Model: Reading Score ~ Lunch
# -----------------------------------------------
model_reading_lunch <- stan_glm(
  reading_score ~ lunch,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 123
)

save(model_reading_lunch, file = "results/model_summaries/lunch_reading_model.RData")
posterior_reading <- as_draws_df(model_reading_lunch)
prob_reading <- mean(posterior_reading$lunchstandard > 0)
cat("Probability that standard lunch students score higher in reading:", round(prob_reading, 3), "\n")

p_reading <- mcmc_areas(
  posterior_reading,
  pars = "lunchstandard",
  prob = 0.95
) +
  labs(title = "Posterior: Lunch Status Effect on Reading Score",
       x = "Estimated Effect (points)")

ggsave("results/figures/posterior_lunch_reading.png", plot = p_reading, width = 8, height = 4)

# -----------------------------------------------
# 5. Model: Writing Score ~ Lunch
# -----------------------------------------------
model_writing_lunch <- stan_glm(
  writing_score ~ lunch,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 123
)

save(model_writing_lunch, file = "results/model_summaries/lunch_writing_model.RData")
posterior_writing <- as_draws_df(model_writing_lunch)
prob_writing <- mean(posterior_writing$lunchstandard > 0)
cat("Probability that standard lunch students score higher in writing:", round(prob_writing, 3), "\n")

p_writing <- mcmc_areas(
  posterior_writing,
  pars = "lunchstandard",
  prob = 0.95
) +
  labs(title = "Posterior: Lunch Status Effect on Writing Score",
       x = "Estimated Effect (points)")

ggsave("results/figures/posterior_lunch_writing.png", plot = p_writing, width = 8, height = 4)
