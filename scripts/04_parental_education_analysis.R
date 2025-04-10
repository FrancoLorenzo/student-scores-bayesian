# 04_parental_education_analysis.R - Bayesian Model: Parental Education Effect

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
    parental_education = `parental.level.of.education`,
    math_score = `math.score`,
    reading_score = `reading.score`,
    writing_score = `writing.score`
  ) %>%
  mutate(parental_education = factor(parental_education))

# -----------------------------------------------
# 3. Model: Math Score ~ Parental Education
# -----------------------------------------------
model_math_pe <- stan_glm(
  math_score ~ parental_education,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 123
)

save(model_math_pe, file = "results/model_summaries/parental_edu_math_model.RData")

posterior_math_pe <- as_draws_df(model_math_pe)

# Plot
p_math <- mcmc_areas(
  posterior_math_pe,
  pars = grep("parental_education", colnames(posterior_math_pe), value = TRUE),
  prob = 0.95
) +
  labs(title = "Posterior: Parental Education Effect on Math Score",
       x = "Estimated Effect vs. Reference (some high school)")

ggsave("results/figures/posterior_parental_edu_math.png", plot = p_math, width = 9, height = 5)

# -----------------------------------------------
# 4. Model: Reading Score ~ Parental Education
# -----------------------------------------------
model_reading_pe <- stan_glm(
  reading_score ~ parental_education,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 123
)

save(model_reading_pe, file = "results/model_summaries/parental_edu_reading_model.RData")
posterior_reading_pe <- as_draws_df(model_reading_pe)

# Plot
p_reading <- mcmc_areas(
  posterior_reading_pe,
  pars = grep("parental_education", colnames(posterior_reading_pe), value = TRUE),
  prob = 0.95
) +
  labs(title = "Posterior: Parental Education Effect on Reading Score",
       x = "Estimated Effect vs. Reference (some high school)")

ggsave("results/figures/posterior_parental_edu_reading.png", plot = p_reading, width = 9, height = 5)

# -----------------------------------------------
# 5. Model: Writing Score ~ Parental Education
# -----------------------------------------------
model_writing_pe <- stan_glm(
  writing_score ~ parental_education,
  data = df,
  family = gaussian(),
  prior = normal(0, 10),
  prior_intercept = normal(0, 10),
  chains = 4,
  iter = 2000,
  seed = 123
)

save(model_writing_pe, file = "results/model_summaries/parental_edu_writing_model.RData")
posterior_writing_pe <- as_draws_df(model_writing_pe)

# Plot
p_writing <- mcmc_areas(
  posterior_writing_pe,
  pars = grep("parental_education", colnames(posterior_writing_pe), value = TRUE),
  prob = 0.95
) +
  labs(title = "Posterior: Parental Education Effect on Writing Score",
       x = "Estimated Effect vs. Reference (some high school)")

ggsave("results/figures/posterior_parental_edu_writing.png", plot = p_writing, width = 9, height = 5)
