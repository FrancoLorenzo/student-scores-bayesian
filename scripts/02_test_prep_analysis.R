# 02_test_prep_analysis.R - Bayesian Model: Test Prep Effect on Scores

# -----------------------------------------------
# 1. Load Packages
# -----------------------------------------------
library(tidyverse)
# install.packages("rstanarm", repos = "https://cloud.r-project.org/", dependencies = TRUE)
library(rstanarm)
library(bayesplot)
library(posterior)

# -----------------------------------------------
# 2. Load Data
# -----------------------------------------------
df <- read.csv("data/Students-Scores.csv")

df <- df %>%
  rename(
    test_prep = `test.preparation.course`,
    math_score = `math.score`,
    reading_score = `reading.score`,
    writing_score = `writing.score`
  ) %>%
  mutate(test_prep = factor(test_prep, levels = c("none", "completed")))

# -----------------------------------------------
# 3. Bayesian Model: Math Score ~ Test Prep
# -----------------------------------------------
model_math <- stan_glm(
  math_score ~ test_prep,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 42
)

# Save model
if (!dir.exists("results/model_summaries")) dir.create("results/model_summaries", recursive = TRUE)
save(model_math, file = "results/model_summaries/test_prep_math_model.RData")

# Print summary
print(summary(model_math), digits = 2)

# -----------------------------------------------
# 4. Posterior Analysis
# -----------------------------------------------
posterior_samples <- as_draws_df(model_math)
prob_improvement <- mean(posterior_samples$test_prepcompleted > 0)
cat("Probability that test preparation improves math score:", round(prob_improvement, 3), "\n")

# -----------------------------------------------
# 5. Plot Posterior Distribution
# -----------------------------------------------
p <- mcmc_areas(
  posterior_samples,
  pars = "test_prepcompleted",
  prob = 0.95
) +
  labs(title = "Posterior: Effect of Test Preparation on Math Score",
       x = "Estimated Effect (points)",
       y = "Density")

ggsave("results/figures/posterior_test_prep_math.png", plot = p, width = 8, height = 4)

# -----------------------------------------------
# 6. Bayesian Model: Reading Score ~ Test Prep
# -----------------------------------------------
model_reading <- stan_glm(
  reading_score ~ test_prep,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 42
)

# Save model
save(model_reading, file = "results/model_summaries/test_prep_reading_model.RData")

# Posterior summary + improvement probability
posterior_reading <- as_draws_df(model_reading)
prob_reading <- mean(posterior_reading$test_prepcompleted > 0)
cat("Probability that test preparation improves reading score:", round(prob_reading, 3), "\n")

# Plot
plot_reading <- mcmc_areas(
  posterior_reading,
  pars = "test_prepcompleted",
  prob = 0.95
) +
  labs(title = "Posterior: Effect of Test Preparation on Reading Score",
       x = "Estimated Effect (points)")

ggsave("results/figures/posterior_test_prep_reading.png", plot = plot_reading, width = 8, height = 4)

# -----------------------------------------------
# 7. Bayesian Model: Writing Score ~ Test Prep
# -----------------------------------------------
model_writing <- stan_glm(
  writing_score ~ test_prep,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 42
)

# Save model
save(model_writing, file = "results/model_summaries/test_prep_writing_model.RData")

# Posterior summary + improvement probability
posterior_writing <- as_draws_df(model_writing)
prob_writing <- mean(posterior_writing$test_prepcompleted > 0)
cat("Probability that test preparation improves writing score:", round(prob_writing, 3), "\n")

# Plot
plot_writing <- mcmc_areas(
  posterior_writing,
  pars = "test_prepcompleted",
  prob = 0.95
) +
  labs(title = "Posterior: Effect of Test Preparation on Writing Score",
       x = "Estimated Effect (points)")

ggsave("results/figures/posterior_test_prep_writing.png", plot = plot_writing, width = 8, height = 4)

