# BivLaplaceRL

**BivLaplaceRL** is an R package for bivariate Laplace transforms,
stochastic ordering concepts, and entropy measures in reliability
analysis. It consolidates the methods from three research publications
into a single, CRAN-ready package.

## Research Basis

| Paper | Journal | Authors |
|----|----|----|
| Bivariate Laplace transform of residual lives and their properties | *Communications in Statistics — Theory and Methods* (2022) | Jayalekshmi S., Rajesh G., Nair N.U. |
| Bivariate Laplace transform order and ordering of reversed residual lives | *Int. J. Reliability, Quality and Safety Engineering* | Jayalekshmi S., Rajesh G. |
| On residual entropy generating function | *Journal of the Indian Statistical Association* 62(1):81–93 (2024) | Smitha S., Rajesh G., Jayalekshmi S. |

## Features

### Parametric Distributions

- Gumbel bivariate exponential (`dgumbel_biv`, `sgumbel_biv`,
  `rgumbel_biv`, `pgumbel_biv`)
- Farlie-Gumbel-Morgenstern — FGM (`dfgm_biv`, `pfgm_biv`, `sfgm_biv`,
  `rfgm_biv`)
- Bivariate power distribution (`dbivpower`, `pbivpower`, `sbivpower`,
  `rbivpower`)
- Schur-constant distribution (`sschur_biv`, `rschur_biv`)

### Bivariate Laplace Transform of Residual Lives

- [`blt_residual()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_residual.md)
  — numerical computation for any survival function
- [`blt_residual_gumbel()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_residual_gumbel.md)
  — closed-form for Gumbel distribution
- [`biv_hazard_gradient()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_hazard_gradient.md)
  — bivariate hazard gradient
- [`biv_mean_residual()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_mean_residual.md)
  — bivariate mean residual life
- [`nbuhr_test()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/nbuhr_test.md)
  — NBUHR/NWUHR aging class test
- [`np_blt_residual()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/np_blt_residual.md)
  — nonparametric estimator
- [`sim_blt_residual()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/sim_blt_residual.md)
  — Monte-Carlo simulation study

### Bivariate Laplace Transform of Reversed Residual Lives

- [`blt_reversed()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_reversed.md)
  — for any joint CDF
- [`blt_reversed_fgm()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_reversed_fgm.md)
  — closed form for FGM
- [`blt_reversed_power()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_reversed_power.md)
  — for bivariate power distribution
- [`biv_rhazard_gradient()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_rhazard_gradient.md)
  — reversed hazard gradient
- [`biv_rmrl()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_rmrl.md)
  — reversed mean residual life

### Stochastic Orders

- [`blt_order_residual()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_order_residual.md)
  — BLt-rl order
- [`blt_order_reversed()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_order_reversed.md)
  — BLt-Rrl order
- [`biv_whr_order()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_whr_order.md)
  — weak bivariate hazard rate order
- [`biv_wmrl_order()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_wmrl_order.md)
  — weak bivariate MRL order
- [`biv_brlmr_order()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_brlmr_order.md)
  — bivariate relative MRL order
- [`biv_wrhr_order()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_wrhr_order.md)
  — weak bivariate reversed hazard rate order
- [`biv_wrmrl_order()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_wrmrl_order.md)
  — weak bivariate reversed MRL order

### Entropy Measures

- [`shannon_entropy()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/shannon_entropy.md)
  — Shannon differential entropy
- [`info_gen_function()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/info_gen_function.md)
  — Golomb information generating function
- [`residual_entropy()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/residual_entropy.md)
  — dynamic residual entropy (Ebrahimi & Pellerey 1995)
- [`residual_info_gen()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/residual_info_gen.md)
  — residual entropy generating function (REGF)
- [`regf_profile()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/regf_profile.md)
  — REGF profile over α
- [`regf_characterise()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/regf_characterise.md)
  — distribution characterisation via REGF
- [`np_residual_info_gen()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/np_residual_info_gen.md)
  — nonparametric REGF estimator
- [`sim_regf()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/sim_regf.md)
  — Monte-Carlo simulation for REGF estimator

### Plotting

- [`plot_blt_residual()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/plot_blt_residual.md),
  [`plot_blt_reversed()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/plot_blt_reversed.md),
  [`plot_regf()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/plot_regf.md)

## Installation

``` r
# Development version from GitHub
# install.packages("devtools")
devtools::install_github("maheshdivakaran/BivLaplaceRL")
```

Once on CRAN:

``` r
install.packages("BivLaplaceRL")
```

## Quick Start

``` r
library(BivLaplaceRL)

# 1. Simulate from Gumbel bivariate exponential
set.seed(42)
dat <- rgumbel_biv(500, k1 = 1, k2 = 1, theta = 0.5)

# 2. Nonparametric estimate of BLT of residual lives
np_blt_residual(dat, s1 = 1, s2 = 1, t1 = 0.3, t2 = 0.3)

# 3. Compare with closed-form
blt_residual_gumbel(s1 = 1, s2 = 1, t1 = 0.3, t2 = 0.3, k1 = 1, k2 = 1, theta = 0.5)

# 4. Check weak bivariate hazard rate order
sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 2, k2 = 2)
sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1)
biv_whr_order(sX, sY)$order_holds

# 5. Residual Entropy Generating Function
f  <- function(x) dexp(x, rate = 1)
Fb <- function(x) pexp(x, rate = 1, lower.tail = FALSE)
residual_info_gen(f, Fb, alpha = 2, t = 0.5)
```

## Authors

**Mahesh Divakaran** (maintainer) Research Scholar, Amity School of
Applied Sciences, Amity University Lucknow <imaheshdivakaran@gmail.com>

**S. Jayalekshmi**, **G. Rajesh**, **N. Unnikrishnan Nair** Department
of Statistics, Cochin University of Science and Technology

**Smitha S.** K. E. College, Mannanam

## References

Jayalekshmi S., Rajesh G., Nair N.U. (2022). Bivariate Laplace transform
of residual lives and their properties. *Communications in Statistics —
Theory and Methods*. <https://doi.org/10.1080/03610926.2022.2085874>

Jayalekshmi S., Rajesh G. Bivariate Laplace transform order and ordering
of reversed residual lives. *International Journal of Reliability,
Quality and Safety Engineering*.

Smitha S., Rajesh G., Jayalekshmi S. (2024). On residual entropy
generating function. *Journal of the Indian Statistical Association*,
62(1), 81–93.

## License

GPL-3 © 2024 Mahesh Divakaran
