
# Two-Way ANOVA in R — Complete Guide

##  Overview

Two-Way ANOVA (Analysis of Variance) is a statistical method used to evaluate:

-   The effect of **two categorical independent variables (factors)**
-   On a **single continuous dependent variable**
-   Including whether there is an **interaction effect** between the two factors

This technique is widely used in experimental design, A/B testing, and data analysis workflows.

----------

##  Prerequisites

Before you begin, ensure you have:

-    R (version 3.6 or higher) installed
-    Basic knowledge of R programming
-    Foundational understanding of ANOVA concepts

----------

##  Installation

Install the required packages:

```
install.packages(c("ggplot2",  "dplyr",  "car"))
``` 

Load them:

```
library(ggplot2)
library(dplyr)
library(car)
```

----------

##  Workflow: Performing Two-Way ANOVA

### 1. Load Your Data

```
data <- read.csv("path_to_your_dataset.csv")
head(data)
``` 

----------

### 2. Inspect and Prepare Data

Check structure:

```
str(data)
```

Ensure:

-   Independent variables → **Factors**
-   Dependent variable → **Numeric**

Convert if necessary:

```
data$Factor1 <- as.factor(data$Factor1) data$Factor2 <- as.factor(data$Factor2)
``` 

----------

### 3. Run the Two-Way ANOVA

```
anova_result <- aov(DependentVariable ~ Factor1 * Factor2, data = data) summary(anova_result)
``` 

 The `*` includes:

-   Main effects (Factor1, Factor2)
-   Interaction effect (Factor1:Factor2)

----------

##  Assumption Checks

### 4. Homogeneity of Variance

```
leveneTest(DependentVariable ~ Factor1 * Factor2, data = data)
```

✔️ _p > 0.05 → assumption satisfied_

----------

### 5. Normality of Residuals

#### Q-Q Plot

```
qqnorm(residuals(anova_result)) qqline(residuals(anova_result))
```

#### Shapiro-Wilk Test

```
shapiro.test(residuals(anova_result))
```

✔️ _p > 0.05 → residuals are approximately normal_

----------

##  Interpreting Results

From `summary(anova_result)`:

| Component           | Meaning                               |
| ------------------- | ------------------------------------- |
| **Factor1**         | Effect of first independent variable  |
| **Factor2**         | Effect of second independent variable |
| **Factor1:Factor2** | Interaction between the two factors   |


###  Key Insight

-   Significant interaction = **effect of one factor depends on the other**
-   If interaction is significant → interpret interaction _first_, not main effects

----------

##  Post-Hoc Analysis

If significant differences are detected:

```
TukeyHSD(anova_result)
```

This identifies **which specific groups differ**.

----------

##  Visualization (Interaction Plot)

```
ggplot(data, aes(x = Factor1, y = DependentVariable, color = Factor2))  + 
   geom_point(position = position_jitterdodge())  + 
   stat_summary(fun = mean, geom =  "line", aes(group = Factor2))  + 
   labs( 
   title =  "Interaction Plot", 
   x =  "Factor 1", 
   y =  "Dependent Variable"  
   )  + 
   theme_minimal()
```

 This helps you visually confirm interaction patterns.

----------

##  Example

```
data <- data.frame(
  Factor1 = factor(rep(c("A", "B"), each = 10)),
  Factor2 = factor(rep(c("X", "Y"), 10)),
  DependentVariable = c(
    23, 21, 19, 30, 29, 31, 23, 22, 24, 26,
    30, 28, 25, 27, 29, 22, 24, 21, 23, 20
  )
)

anova_result <- aov(DependentVariable ~ Factor1 * Factor2, data = data)
summary(anova_result)
```

----------

##  Common Pitfalls

-    Treating numeric variables as factors incorrectly
-    Ignoring interaction effects
-    Skipping assumption checks
-    Small sample sizes → unreliable results

----------

##  Best Practices

-   Always visualize before and after analysis
-   Check assumptions **before interpreting results**
-   Use post-hoc tests when significant effects exist
-   Keep your data clean and well-structured
