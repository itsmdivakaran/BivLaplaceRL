# Introduction to BivLaplaceRL

## Overview

**BivLaplaceRL** is an R package that implements statistical methods
from two research papers on bivariate Laplace transforms in reliability
theory, together with a set of univariate residual life tools:

1.  Bivariate Laplace transform of residual lives (Jayalekshmi, Rajesh &
    Nair, 2022)
2.  Bivariate Laplace transform order of reversed residual lives
    (Jayalekshmi & Rajesh)

``` r
library(BivLaplaceRL)
```

## Parametric Distributions

The package provides four bivariate distributions commonly used in
reliability modelling.

### Gumbel Bivariate Exponential

``` r
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
sgumbel_biv(1, 1, k1 = 1, k2 = 1.5, theta = 0.3)
#> [1] 0.06081006
```

### Farlie-Gumbel-Morgenstern (FGM)

``` r
set.seed(1)
dat_fgm <- rfgm_biv(100, theta = 0.5)
pfgm_biv(0.5, 0.6, theta = 0.5)
#> [1] 0.33
```

### Schur-Constant

``` r
set.seed(2)
dat_sc <- rschur_biv(100, lambda = 1)
summary(rowSums(dat_sc))
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#> 0.00394 0.34161 0.82448 1.00673 1.29280 4.86222
```

## Bivariate Laplace Transform of Residual Lives

### Closed-Form (Gumbel Distribution)

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
biv_hazard_gradient(t1 = 1, t2 = 1, k1 = 1, k2 = 1, theta = 0.3)
#>  h1  h2 
#> 1.3 1.3
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
blt_reversed(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5, theta = 0.3)
#>       L1       L2 
#> 0.791495 0.791495
biv_rhazard_gradient(x1 = 0.5, x2 = 0.5, theta = 0.3)
#>      rh1      rh2 
#> 1.860465 1.860465
biv_rmrl(x1 = 0.5, x2 = 0.5, theta = 0.3)
#>       m1       m2 
#> 0.255814 0.255814
```

## Bivariate Stochastic Orders

``` r
sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1, theta = 0.2)
sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 2, k2 = 2, theta = 0.2)
res <- blt_order_residual(sX, sY, s1 = 1, s2 = 1,
                          t1_grid = c(0.5, 1), t2_grid = c(0.5, 1))
cat("X <=_BLt-rl Y:", res$order_holds, "\n")
#> X <=_BLt-rl Y: TRUE

res2 <- biv_whr_order(sX, sY, t1_grid = c(0.5, 1), t2_grid = c(0.5, 1))
cat("X <=_whr Y:", res2$order_holds, "\n")
#> X <=_whr Y: FALSE
```

## Univariate Residual Life Analysis

The package now provides a complete set of univariate residual life
tools that complement the bivariate framework.

### Laplace Transform of Residual Life

For a non-negative continuous random variable $`X`$ with density $`f`$
and survival function $`\bar{F}`$:

``` math
L_X(s,t) = E[e^{-sX} \mid X > t]
  = \frac{1}{\bar{F}(t)}\int_t^\infty e^{-sx} f(x)\,dx.
```

``` r
f  <- function(x) dexp(x, 1)
Fb <- function(x) pexp(x, 1, lower.tail = FALSE)

# At t=0: L_X(1, 0) = 1/(1+1) = 0.5
lt_residual(f, Fb, s = 1, t = 0)
#> [1] 0.5

# At t=0.5
lt_residual(f, Fb, s = 1, t = 0.5)
#> [1] 0.3032653
```

### Hazard Rate and MRL

``` r
# Exp(1): constant hazard rate = 1
hazard_rate(f, Fb, t = c(0.5, 1, 2))
#> [1] 1 1 1

# Exp(1): constant MRL = 1 (memoryless)
mean_residual(Fb, t = c(0, 0.5, 1, 2))
#> [1] 1 1 1 1

# Gamma(2,1): increasing hazard, decreasing MRL
fG  <- function(x) dgamma(x, shape = 2, rate = 1)
FbG <- function(x) pgamma(x, shape = 2, rate = 1, lower.tail = FALSE)
hazard_rate(fG, FbG, t = c(0.5, 1, 2))
#> [1] 0.3333333 0.5000000 0.6666667
mean_residual(FbG, t = c(0, 0.5, 1))
#> [1] 2.000000 1.666667 1.500000
```

### Nonparametric Estimation

``` r
set.seed(7)
x <- rexp(500, rate = 1)

# Nonparametric estimate at s=1, t=0: true value = 0.5
np_lt_residual(x, s = 1, t = 0)
#> [1] 0.4948948

# At t=0.5
np_lt_residual(x, s = 1, t = 0.5)
#> [1] 0.3142664
```

### Univariate Stochastic Orders

``` r
f1  <- function(x) dexp(x, 1)
Fb1 <- function(x) pexp(x, 1, lower.tail = FALSE)
f2  <- function(x) dexp(x, 2)
Fb2 <- function(x) pexp(x, 2, lower.tail = FALSE)

# LT-rl order: Exp(1) <=_Lt-rl Exp(2)?
lt_rl_order(f1, Fb1, f2, Fb2,
            s_grid = c(0.5, 1, 2), t_grid = c(0, 0.5, 1))$order_holds
#> [1] TRUE

# Hazard rate order: Exp(1) <=_hr Exp(2)?
hr_order(f1, Fb1, f2, Fb2, t_grid = c(0.5, 1, 2))$order_holds
#> [1] TRUE

# MRL order: Exp(2) <=_mrl Exp(1)?
mrl_order(Fb2, Fb1, t_grid = c(0, 0.5, 1, 2))$order_holds
#> [1] TRUE
```

## Entropy and Information Generating Functions

``` r
# Shannon entropy of Exp(1) = 1
shannon_entropy(function(x) dexp(x, 1))
#> [1] 1

# Golomb IGF of Exp(1) at alpha=2: 0.5
info_gen_function(function(x) dexp(x, 1), alpha = 2)
#> [1] 0.5
```

## References

Jayalekshmi S., Rajesh G., Nair N.U. (2022). Bivariate Laplace transform
of residual lives and their properties. *Communications in
Statistics—Theory and Methods*.
<https://doi.org/10.1080/03610926.2022.2085874>

Jayalekshmi S., Rajesh G., Nair N.U. (2022). Bivariate Laplace transform
order and ordering of reversed residual lives. *International Journal of
Reliability, Quality and Safety Engineering*.
<https://doi.org/10.1142/S0218539322500061>

Belzunce F., Ortega E., Ruiz J.M. (1999). The Laplace order and ordering
of residual lives. *Statistics & Probability Letters*, 42(2), 145–156.
<https://doi.org/10.1016/S0167-7152(98)00202-8>
