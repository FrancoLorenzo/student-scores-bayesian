# 📊 Bayesian Analysis of Student Scores

This project presents a Bayesian analysis of high school student performance using demographic and educational background data. The goal is to identify patterns that can help educators make informed, actionable decisions to support student success.

## 🧠 Overview

Bayesian inference was used to analyze how factors such as:

- Gender  
- Race/Ethnicity  
- Parental Education Level  
- Lunch Program Status  
- Completion of Test Preparation Course  

affect student scores in **Math**, **Reading**, and **Writing**.

By modeling these effects using credible intervals, we can directly assess the probability and uncertainty of meaningful educational interventions.

---

## 📁 Project Structure

├── data/ # (Optional) Raw or cleaned dataset
├── scripts/ # R scripts used to run the analysis
├── results/
│ └── figures/ # Posterior distributions & EDA plots
├── student_scores_bayesian_report.pdf # Final report (compiled R Markdown)
└── README.md # You're here!


---

## 📄 Key Findings

- **Test preparation courses** are strongly associated with better performance, especially in writing.
- **Parental education** and **lunch program status** reflect broader socioeconomic effects.
- **Gender** differences suggest potential need for targeted writing support for male students.
- **Race/ethnicity** differences exist, but should be used to promote equity—not reinforce bias.

The credible intervals help determine which effects are meaningful enough to inform educational strategies.

---

## 🔍 Methodology

- **Framework**: Bayesian inference with `rstanarm` and default priors.  
- **Visualization**: `ggplot2` and `bayesplot` for EDA and posterior summaries.  
- **Interpretability**: Credible intervals allow direct understanding of uncertainty and effect strength.  

---

## 📘 Report

You can read the full report [here](./student_scores_bayesian_report.pdf), which includes:

- Visual summaries  
- Explanations accessible to general and technical audiences  
- Reflections on limitations (e.g., only one year of data)  
- Discussion of model reliability  

---

## 📦 Dependencies

To replicate this analysis in R:

```r
# Required R packages
install.packages(c("rstanarm", "bayesplot", "ggplot2", "dplyr", "readr", "knitr"))
```

## 📌 Notes

- The dataset includes 1,000 student records and is for educational purposes only.  
- This project was completed as part of the *Bayesian Computational Statistics* course at **Illinois Institute of Technology**.

---

## 🧑‍💻 Author

**Franco Lorenzo**  
[GitHub](https://github.com/francolorenzo)

---

## 📜 License

This project is licensed under the **MIT License** — feel free to use, modify, and share.
