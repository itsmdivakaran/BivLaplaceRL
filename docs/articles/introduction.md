# Introduction to BivLaplaceRL

## Overview

**BivLaplaceRL** is an R package that implements statistical methods
from three research papers on bivariate Laplace transforms and entropy
measures in reliability theory:

1.  Bivariate Laplace transform of residual lives (Jayalekshmi, Rajesh &
    Nair, 2022)
2.  Bivariate Laplace transform order of reversed residual lives
    (Jayalekshmi & Rajesh)
3.  Residual entropy generating function (Smitha, Rajesh & Jayalekshmi,
    2024)

``` r
library(BivLaplaceRL)
```

## Parametric Distributions

The package provides four bivariate distributions commonly used in
reliability modelling.

### Gumbel Bivariate Exponential

``` r
# Simulate 200 observations
set.seed(42)
dat <- rgumbel_biv(200, k1 = 1, k2 = 1.5, theta = 0.3)
head(dat)
#>             X1          X2
#> [1,] 0.1983368 0.520919155
#> [2,] 0.6608953 0.076339189
#> [3,] 0.2834910 0.156729738
#> [4,] 0.0381919 0.294297662
#> [5,] 0.4731766 0.305411898
#> [6,] 1.4636271 0.000850079

# Survival function at a point
sgumbel_biv(1, 1, k1 = 1, k2 = 1.5, theta = 0.3)
#> [1] 0.06081006
```

### Farlie-Gumbel-Morgenstern (FGM)

``` r
set.seed(1)
dat_fgm <- rfgm_biv(100, theta = 0.5)
head(dat_fgm)
#>             X1        X2
#> [1,] 0.2655087 0.4050251
#> [2,] 0.3721239 0.4433111
#> [3,] 0.5728534 0.5392890
#> [4,] 0.9082078 0.8448911
#> [5,] 0.2016819 0.3851136
#> [6,] 0.8983897 0.2511579
pfgm_biv(0.5, 0.6, theta = 0.5)
#> [1] 0.33
```

### Schur-Constant

``` r
set.seed(2)
dat_sc <- rschur_biv(100, lambda = 1)
# Marginals are standard exponential
summary(rowSums(dat_sc))  # T = X1 + X2 ~ Exp(lambda)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#> 0.00394 0.34161 0.82448 1.00673 1.29280 4.86222
```

## Bivariate Laplace Transform of Residual Lives

### Closed-Form (Gumbel Distribution)

The key result from Jayalekshmi et al. (2022) is:

``` math
L^*_{X_{t_1|t_2}}(s_1) = \frac{1}{k_1 + s_1 + \theta t_2}, \quad
  L^*_{X_{t_2|t_1}}(s_2) = \frac{1}{k_2 + s_2 + \theta t_1}.
```

``` r
blt_residual_gumbel(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5,
                    k1 = 1, k2 = 1, theta = 0.5)
#>   L1_star   L2_star 
#> 0.4444444 0.4444444
```

### Numerical Computation

For a user-supplied survival function:

``` r
my_surv <- function(x1, x2) exp(-x1 - x2 - 0.3 * x1 * x2)
blt_residual(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5,
             surv_fn = my_surv, star = TRUE)
#>   L1_star   L2_star 
#> 0.4651163 0.4651163
```

### Nonparametric Estimation

``` r
set.seed(123)
dat <- rgumbel_biv(500, k1 = 1, k2 = 1, theta = 0.5)
np_blt_residual(dat, s1 = 1, s2 = 1, t1 = 0.3, t2 = 0.3)
#>    L1_hat    L2_hat 
#> 0.4743203 0.3849056

# True value
blt_residual_gumbel(s1 = 1, s2 = 1, t1 = 0.3, t2 = 0.3, theta = 0.5)
#>   L1_star   L2_star 
#> 0.4651163 0.4651163
```

### Simulation Study

``` r
sim_blt_residual(n_obs = 200, n_sim = 50, s1 = 1, s2 = 1,
                 t1 = 0.3, t2 = 0.3, k1 = 1, k2 = 1, theta = 0.5)
#>         component true_value  mean_est         bias     variance          mse
#> L1_star   L1_star  0.4651163 0.4682817  0.003165417 0.0009658125 0.0009758324
#> L2_star   L2_star  0.4651163 0.3951277 -0.069988580 0.0004963515 0.0053947528
```

## Bivariate Hazard Gradient and MRL

``` r
# Hazard gradient
biv_hazard_gradient(t1 = 1, t2 = 1, k1 = 1, k2 = 1, theta = 0.3)
#>  h1  h2 
#> 1.3 1.3

# Mean residual life
biv_mean_residual(t1 = 0.5, t2 = 0.5, k1 = 1, k2 = 1, theta = 0)
#> m1 m2 
#>  1  1
```

## NBUHR / NWUHR Aging Classification

``` r
res <- nbuhr_test(t2 = 0.5, k1 = 1, k2 = 1, theta = 0.3,
                  t1_grid = seq(0.1, 3, 0.3))
cat("Component 1:", res$class1, "\n")
#> Component 1: neither
cat("Component 2:", res$class2, "\n")
#> Component 2: NWUHR
```

## Bivariate Laplace Transform of Reversed Residual Lives

``` r
# FGM distribution
blt_reversed(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5, theta = 0.3)
#>       L1       L2 
#> 0.791495 0.791495

# G form (used for characterisation)
blt_reversed(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5, theta = 0.3, g_form = TRUE)
#>        G1        G2 
#> 0.3049546 0.3049546

# Reversed hazard gradient
biv_rhazard_gradient(x1 = 0.5, x2 = 0.5, theta = 0.3)
#>      rh1      rh2 
#> 1.860465 1.860465

# Reversed MRL
biv_rmrl(x1 = 0.5, x2 = 0.5, theta = 0.3)
#>       m1       m2 
#> 0.255814 0.255814
```

## Stochastic Orders

### BLt-rl Order

``` r
sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1, theta = 0.2)
sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 2, k2 = 2, theta = 0.2)
res <- blt_order_residual(sX, sY, s1 = 1, s2 = 1,
                          t1_grid = c(0.5, 1), t2_grid = c(0.5, 1))
cat("X <=_BLt-rl Y:", res$order_holds, "\n")
#> X <=_BLt-rl Y: TRUE
```

### Weak Bivariate Hazard Rate Order

``` r
res <- biv_whr_order(sX, sY, t1_grid = c(0.5, 1), t2_grid = c(0.5, 1))
cat("X <=_whr Y:", res$order_holds, "\n")
#> X <=_whr Y: FALSE
```

## Residual Entropy Generating Function

### Shannon Entropy and Golomb IGF

``` r
# Shannon entropy of Exp(1) = 1
shannon_entropy(function(x) dexp(x, 1))
#> [1] 1

# Golomb IGF of Exp(1) at alpha=2: lambda/2 = 0.5
info_gen_function(function(x) dexp(x, 1), alpha = 2)
#> [1] 0.5
```

### Dynamic REGF

``` r
f  <- function(x) dexp(x, 1)
Fb <- function(x) pexp(x, 1, lower.tail = FALSE)

# REGF at various t values
t_vals <- seq(0, 2, 0.5)
sapply(t_vals, function(t) residual_info_gen(f, Fb, alpha = 2, t = t))
#> [1] 0.5 0.5 0.5 0.5 0.5
```

### Nonparametric Estimation

``` r
set.seed(7)
x <- rexp(300, rate = 1)
np_residual_info_gen(x, alpha = 2, t = 0.5)
#> [1] 0.5736774

# True value
residual_info_gen(f, Fb, alpha = 2, t = 0.5)
#> [1] 0.5
```

### REGF Profile and Characterisation

``` r
prof <- regf_profile(f, Fb, t = 0.5, plot = TRUE)
```

![REGF profile across
alpha](introduction_files/figure-html/regf_profile-1.png)

REGF profile across alpha

``` r
head(prof)
#>   alpha      REGF
#> 1   0.1 9.9995227
#> 2   0.3 3.3333333
#> 3   0.5 2.0000000
#> 4   0.7 1.4285714
#> 5   0.9 1.1111111
#> 6   1.1 0.9090909
```

``` r
# Log-linearity in t characterises exponential distribution
ch <- regf_characterise(f, Fb, alpha = 2, t_grid = seq(0, 2, 0.4))
ch
#>     t REGF      log_REGF        slope
#> 1 0.0  0.5  0.000000e+00 4.123686e-16
#> 2 0.4  0.5 -1.221245e-15 4.123686e-16
#> 3 0.8  0.5  6.661338e-16 4.123686e-16
#> 4 1.2  0.5  1.110223e-15 4.123686e-16
#> 5 1.6  0.5  1.110223e-15 4.123686e-16
#> 6 2.0  0.5 -3.330669e-16 4.123686e-16
```

### Simulation Study for REGF Estimator

``` r
sim_regf(lambda = 1, alpha = 2, t = 0, n_obs = 200, n_sim = 50)
#>   true_value  mean_est        bias    variance         mse
#> 1        0.5 0.4158333 -0.08416671 0.001263665 0.008347701
```

## References

Jayalekshmi S., Rajesh G., Nair N.U. (2022). Bivariate Laplace transform
of residual lives and their properties. *Communications in
Statistics—Theory and Methods*.
<https://doi.org/10.1080/03610926.2022.2085874>

Jayalekshmi S., Rajesh G. Bivariate Laplace transform order and ordering
of reversed residual lives. *International Journal of Reliability,
Quality and Safety Engineering*.

Smitha S., Rajesh G., Jayalekshmi S. (2024). On residual entropy
generating function. *Journal of the Indian Statistical Association*,
62(1), 81–93.
