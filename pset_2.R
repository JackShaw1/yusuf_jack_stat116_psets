---
title: "Problem Set 2: Survival"
author: "Statistics 116 Teaching Staff"
date: "Due: October 21, 2024"
output: pdf_document
---

\newcommand{\noin}{\noindent}    
\newcommand{\Var}{\text{Var}}    
\newcommand{\Cov}{\text{Cov}}    

\begin{small} 
		
\noindent This assignment is \textbf{due Monday, October 21 at 11:59pm}, handed into the course website on Canvas through the ``Assignments'' section of the website (\textbf{provide both the pdf and rmd files}).  Show your work and provide clear, convincing, and succinct explanations when asked.  \textbf{Incorporate the \underline{relevant} R output in this R markdown file}; choose the included R wisely. Only the key output should be displayed for each problem and the relevant parts should be \textbf{highlighted} in some way.  Make sure that you write-up any interpretation of R-code in your own words (don't just provide the output).


\vspace{0.1in}

\noindent \textbf{Collaboration policy (for this and all future homework)}: You are allowed to officially work and submit this problem set in pairs or individually.  You are encouraged to discuss the problems with other students, but you must write up your solutions yourself or with your official pset partner. Copying someone else's solution, or just making trivial changes is not acceptable. 
		
\end{small}
	
\vspace{0.3in}	


**Problem 1: Like Flipping Coins** 

As seen in class, the Kaplan-Meier estimate of the survivor curve at time $t$ is defined as (where $n_j$ represents the number at risk at time $t_j$ and $d_j$ represents the number of events at this time):
$$\hat{F}(t)=\prod_{j|t_j\leq t} \frac{n_j-d_j}{n_j}$$

(a) Show that this reduces to $\hat{F}(t) = \sum_{i=1}^n\mathbf{1}(t_j\geq t)/n$ when there is no censoring (where $\mathbf{1}(t_j\geq t)$ is the indicator function for whether the $j^{th}$ time-to-event measurement is greater than the time $t$ being considered).

The asymptotic variance of $\hat{F}(t)$ is estimated by:
$$\widehat{Var}\left[ \hat{F}(t)\right]=\hat{F}^2(t)\cdot \sum_{j|t_j\leq t} \frac{d_j}{n_j(n_j-d_j)}$$


(b) Show that this variance expression simplifies to the following formula when there is no censoring:
$$\widehat{Var}\left[ \hat{F}(t)\right] = \frac{\hat{F}(t)\cdot [1-\hat{F}(t)]}{n}$$

(c) What well-known distribution is this simplified variance expression based on? Why does this simplified version make sense?


\vspace{0.3in}

 
**Problem 2: Just a DASH** 

The [Dietary Approaches to Stop Hypertension (DASH) Diet](https://www.nhlbi.nih.gov/education/dash-eating-plan) is a *heart healthy* diet that research has suggested may have health benefits such as lowering blood pressure, improving blood lipid levels, helping people lose weight, and reducing the risk of Type 2 diabetes and heart disease.

The [National Health and Nutrition Examination Survey (NHANES)](https://www.cdc.gov/nchs/nhanes/index.htm) is a collection of observational studies with the goal of measuring and monitoring health statistics across the country.  A subset of this data set has been curated and wrangled to assess whether Americans on the DASH diet may have a lower mortality rate as well.  A portion of this curated data set has been provided to you in the file `dash.csv`, which include the following variables:

 - **time**: follow-up time until event (either censoring or death)
 - **status**: a binary indicator where 1 = death ([all-cause mortality](https://www.cancer.gov/publications/dictionaries/cancer-terms/def/all-cause-mortality)) vs. 0 = censored (due to the end of the study).
 - **diet**: a binary indicator of whether the patient is considered to be on the DASH Diet based on their nutritional survey responses.
  - **age**: age, in years
 - **sex**: a binary indicator where 1 = Female and 0 = Male.
 - **race**: self-reported primary race and ethnicity: 1 = Non-Hispanic White, 2 = Non-Hispanic Black, 1 = Hispanic, or 4 = Other or Multi-racial
 - **bp**: diastolic blood pressure measured at time of enrollment
 - **mi**: a binary indicator of whether respondent has had a myocardial infarction before enrollment (heart attack) 
 - **chf**: a binary indicator of whether respondent has [congestive heart failure](https://my.clevelandclinic.org/health/diseases/17069-heart-failure-understanding-heart-failure) at time of enrollment 
 - **bmi**: [body mass index](https://en.wikipedia.org/wiki/Body_mass_index), in $kg/m^2$.
 - **activity**: a categorical variable for level of weekly activity (walking or more rigorous) with 1 = less than 30 minutes per week, 2 = 30 to 89 minutes per week , 3 = 90 to 179 minutes per week, and 4 = at least 180 minutes per week.

Use this data set to answer the following questions:
 
```{r,echo=F}
#make sure you remove the `echo=F` chunk option above in your answers
library(survival)
dash = read.csv("data/dash.csv")
```

(a) Who's more likely to be on the DASH `diet`?  Answer this question with regards to `race`, `age`, `bmi`, and `mi`.  Please provide visuals and/or summary statistics to address this question -- there is no need to formalize this with CIs or hypothesis test.  Summarize what you find in 4 or fewer sentences.

(b) Plot the 2 empirical survival curves on the same graph (same set of axes): (i) for those on the DASH diet and (ii) for those not on the DASH diet.  Interpret what you notice in 4 or fewer sentences.

(c) Use a log-rank test to determine whether there is evidence of a true difference in the survival function comparing those on the DASH diet vs. those not on the DASH diet.  Perform a formal hypothesis test at the $\alpha = 0.05$ level and provide an associated and interpretable confidence interval for assessing these hypotheses. 

(d) It is thought that those at high-risk for cardiac events -- as measured by a history of myocardial infarction (`mi`), congestive heart failure (`chf`), or elevated blood pressure (`bp`) -- are more likely to be on the DASH diet due to doctor's recommendation, and are expected to have higher all cause mortality rates due to their conditions.  Use a Cox Proportional Hazards model  (call it `cox1`) to assess whether there is an association of survival with `diet` after controlling for these 3 factors.  Summarize what you notice in 4 or fewer sentences.


(e) There are potentially other measured factors that may be confounding this relationship as well (`age`, `sex`, `race`, `bmi`, and `activity`).  Use a Cox Proportional Hazards model (`cox2`) to assess whether there is an association of survival with `diet` after controlling for the 8 mentioned covariates (the 5 listed here and the 3 from the previous part).  Summarize what you notice in 4 or fewer sentences.

(f) Assess the proportional hazards assumptions in `cox2` using diagnostic plots (hint, the R function `cox.zph` may be helpful).  Comments on what you notice in 4 or fewer sentences.

(g) For the `cox2` model, provide two estimated survival curves for the *prototypical* subject in the dataset: one curve if they are on the DASH diet and a second curve if they are not on the DASH diet.  Note: this *prototypical* subject should have the median value for all numeric covariates and the most common response for all categorical covariates other than `diet`. 

(h) Summarize the results above in 6 or fewer sentence: does the DASH diet seem to be a promising intervention to reduce all-cause mortality?  Why or why not?  
  
  
\vspace{0.3in}
    


**Problem 3: Pesky Proportional Hazards** 

In this problem, you are asked to perform a simulation to investigate the affect of a violation to the proportional hazards assumption on a Cox model (use `nsims = 1000` once you have the simulation running properly).  We will sample data from a Weibull($k,\ \lambda$) distribution -- which has pdf:
$$f(y_i) = \lambda k (\lambda y_i)^{k-1} e^{-(\lambda y_i)^k}$$

Note: a Weibull distribution can be shown to have mean $\frac{\Gamma(1+1/k)}{\lambda}$, median $\frac{(\ln(2))^{1/k}}{\lambda}$, and hazard rate $h(y) = \frac{k}{\lambda}\left(\frac{y}{\lambda}\right)^{k-1}$.

For this problem, we will sample from two Weibull distributions to mimic uncensored time-to-event data for control and treatment groups, and then assess any differences in *average* survival time via a Cox proportional hazards model.  

Assume that the control group observations are sampled independently from a Weibull($k_1=1,\ \lambda_1$) distribution  and the active treatment group observations are sampled from a Weibull($k_2,\ c\cdot\lambda_1$) 

(a) Determine the value of $c$ that will make the expected value of the two Weibull distributions equal (you can leave it in terms of the $\Gamma$ function).  Use this value of $c$ through the simulations below.

$$\frac{\Gamma(2)}{\lambda_1} = \frac{\Gamma(1+1/k_2)}{c \lambda_1}$$
$$\Gamma(2) = \frac{\Gamma(1+1/k_2)}{c}$$
$$\boxed{c = \Gamma(1+1/k_2)}$$

(b) Sample $n_1 = n_2 = 100$ observation from each of the distributions above for two situations: with $k_1 = k_2 = 1$ and separately for $k_1 = 1, k_2 = 0.75$ (use $\lambda_1 = 1/10$).  Use a Cox proportional hazard model to calculate a 95% confidence interval for the hazard ratio for the two treatments in each iteration, and report the overall (i) empirical *coverage rate* of an average hazard ratio of 1 and (ii) average width of the CI under these two conditions.

```{r}
library(survival)

# Check if 1 is within the confidence interval
check_one_in_bounds <- function(conf_interval) {
  if (conf_interval[1] <= 0 & conf_interval[2] >= 0) {
    return(1)
  } else {
    return(0)
  }
}

coverage_rate_and_width <- function(n_sims, n = 100, k_control = 1, k_treatment = 1, lambda = 1/10) {
  results_one <- c()  
  widths <- c() 
  
  for (i in 1:n_sims) {
    control_times <- rweibull(n, shape = k_control, scale = lambda)
    treatment_times <- rweibull(n, shape = k_treatment, scale = lambda)
    
    # Create data frames for control and treatment groups
    control_df <- data.frame(time = control_times, status = 1, treatment = FALSE)
    treatment_df <- data.frame(time = treatment_times, status = 1, treatment = TRUE)
    
    combined_df <- rbind(control_df, treatment_df)
    model <- coxph(Surv(time, status) ~ treatment, data = combined_df)
    conf_interval <- confint(model)
    results_one <- c(results_one, check_one_in_bounds(conf_interval))
    
    # Calculate the width of the confidence interval
    width <- conf_interval[2] - conf_interval[1]
    widths <- c(widths, width)
  }
  
  # Calculate the empirical coverage rate (proportion of CIs that include 1)
  coverage_rate <- mean(results_one)
  
  # Calculate the average width of the confidence intervals
  avg_width <- mean(widths)
  
  return(list(coverage_rate = coverage_rate, avg_width = avg_width))
}

set.seed(116)

# Case 1: k_control = k_treatment = 1
result_same <- coverage_rate_and_width(n_sims = 1000, k_control = 1, k_treatment = 1)

# Case 2: k_control = 1, k_treatment = 0.75
result_smaller <- coverage_rate_and_width(n_sims = 1000, k_control = 1, k_treatment = 0.75)

# Print results
cat("Case 1 (k_control = k_treatment = 1):\n")
cat("Coverage rate: ", result_same$coverage_rate, "\n")
cat("Average CI width: ", result_same$avg_width, "\n")

cat("\nCase 2 (k_control = 1, k_treatment = 0.75):\n")
cat("Coverage rate: ", result_smaller$coverage_rate, "\n")
cat("Average CI width: ", result_smaller$avg_width, "\n")

```

*Warning: be careful of what R calls the `scale` parameter of a Weibull distribution as it is $1/\lambda$ based on how we have defined the distribution.

(c) Sample $n_1 = n_2 = 200$ observation from each of the distributions above for two situations: with $k_1 = k_2 = 1$ and separately for $k_1 = 1, k_2 = 0.75$ (use $\lambda_1 = 1/10$). Use a Cox proportional hazard model to calculate a 95% confidence interval for the hazard ratio for the two treatments in each iteration, and report the overall (i) empirical *coverage rate*  of an average hazard ratio of 1 and (ii) average width of the CI under these two conditions.

```{r}
coverage_rate_and_width <- function(n_sims, n = 200, k_control = 1, k_treatment = 1, lambda = 1/10) {
  results_one <- c()  
  widths <- c() 
  
  for (i in 1:n_sims) {
    control_times <- rweibull(n, shape = k_control, scale = lambda)
    treatment_times <- rweibull(n, shape = k_treatment, scale = lambda)
    
    # Create data frames for control and treatment groups
    control_df <- data.frame(time = control_times, status = 1, treatment = FALSE)
    treatment_df <- data.frame(time = treatment_times, status = 1, treatment = TRUE)
    
    combined_df <- rbind(control_df, treatment_df)
    model <- coxph(Surv(time, status) ~ treatment, data = combined_df)
    conf_interval <- confint(model)
    results_one <- c(results_one, check_one_in_bounds(conf_interval))
    
    # Calculate the width of the confidence interval
    width <- conf_interval[2] - conf_interval[1]
    widths <- c(widths, width)
  }
  
  # Calculate the empirical coverage rate (proportion of CIs that include 1)
  coverage_rate <- mean(results_one)
  
  # Calculate the average width of the confidence intervals
  avg_width <- mean(widths)
  
  return(list(coverage_rate = coverage_rate, avg_width = avg_width))
}

set.seed(116)

# Case 1: k_control = k_treatment = 1
result_same <- coverage_rate_and_width(n_sims = 1000, k_control = 1, k_treatment = 1)

# Case 2: k_control = 1, k_treatment = 0.75
result_smaller <- coverage_rate_and_width(n_sims = 1000, k_control = 1, k_treatment = 0.75)

# Print results
cat("Case 1 (k_control = k_treatment = 1):\n")
cat("Coverage rate: ", result_same$coverage_rate, "\n")
cat("Average CI width: ", result_same$avg_width, "\n")

cat("\nCase 2 (k_control = 1, k_treatment = 0.75):\n")
cat("Coverage rate: ", result_smaller$coverage_rate, "\n")
cat("Average CI width: ", result_smaller$avg_width, "\n")
```


(d) Interpret the results: How does a violation of proportional hazard assumption affect the coverage probability and width of the 95% confidence interval?  How does sample size affect the results?  What does this mean for Type 1 and Type 2 error rates?  

__A violation of the proportional hazard assumption generally decreases the coverage probability and increases the width of the CI. For larger sample sizes, the coverage was far worse for the violation of porportional hazard assumption condition. However, the CI width dropped significantly. Increasing the sample size seems to increase the Type II error rate but decrease the Type I error rate.__

