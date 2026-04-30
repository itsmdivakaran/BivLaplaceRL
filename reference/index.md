# Package index

## Parametric Distributions

Four bivariate families used as running examples throughout the package:
Gumbel bivariate exponential, Farlie-Gumbel-Morgenstern (FGM), bivariate
power, and Schur-constant. Each provides d/p/s/r functions where
applicable.

- [`dgumbel_biv()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/gumbel_biv.md)
  [`sgumbel_biv()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/gumbel_biv.md)
  [`pgumbel_biv()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/gumbel_biv.md)
  [`rgumbel_biv()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/gumbel_biv.md)
  : Gumbel Bivariate Exponential Distribution
- [`pfgm_biv()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/fgm_biv.md)
  [`dfgm_biv()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/fgm_biv.md)
  [`sfgm_biv()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/fgm_biv.md)
  [`rfgm_biv()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/fgm_biv.md)
  : Farlie-Gumbel-Morgenstern (FGM) Bivariate Distribution
- [`pbivpower()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/bivpower.md)
  [`sbivpower()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/bivpower.md)
  [`dbivpower()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/bivpower.md)
  [`rbivpower()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/bivpower.md)
  : Bivariate Power Distribution
- [`sschur_biv()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/schur_biv.md)
  [`rschur_biv()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/schur_biv.md)
  : Schur-Constant Bivariate Distribution

## Bivariate Laplace Transform of Residual Lives

Core functions from Jayalekshmi, Rajesh & Nair (2022, *Comm. Stat.*
Theory and Methods). Covers the closed-form Gumbel result, general
numerical integration, bivariate hazard gradient and MRL, NBUHR/NWUHR
aging class characterisation, nonparametric estimation, and a
Monte-Carlo simulator.

- [`blt_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_residual.md)
  : Bivariate Laplace Transform of Residual Lives
- [`blt_residual_gumbel()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_residual_gumbel.md)
  : Closed-Form Bivariate Laplace Transform of Residual Lives (Gumbel)
- [`biv_hazard_gradient()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_hazard_gradient.md)
  : Bivariate Hazard Gradient
- [`biv_mean_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_mean_residual.md)
  : Bivariate Mean Residual Life Function
- [`nbuhr_test()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/nbuhr_test.md)
  : Test NBUHR / NWUHR Aging Class
- [`np_blt_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/np_blt_residual.md)
  : Nonparametric Estimator for the Bivariate Laplace Transform of
  Residual Lives
- [`sim_blt_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/sim_blt_residual.md)
  : Monte-Carlo Simulation Study for the BLT Residual Estimator

## Bivariate Laplace Transform of Reversed Residual Lives

Implements the BLt-Rrl framework from Jayalekshmi & Rajesh (*Int. J.
Reliability, Quality & Safety Eng.*): reversed hazard gradient, reversed
mean residual life, and closed-form results for FGM and bivariate power
distributions.

- [`blt_reversed()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_reversed.md)
  : Bivariate Laplace Transform of Reversed Residual Lives
- [`blt_reversed_fgm()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_reversed_fgm.md)
  : Closed-Form BLT of Reversed Residual Lives for the FGM Distribution
- [`blt_reversed_power()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_reversed_power.md)
  : Bivariate Laplace Transform of Reversed Residual Lives — Power
  Distribution
- [`biv_rhazard_gradient()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_rhazard_gradient.md)
  : Bivariate Reversed Hazard Gradient
- [`biv_rmrl()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_rmrl.md)
  : Bivariate Reversed Mean Residual Life Function

## Univariate Residual Life Analysis

Univariate Laplace transform of residual life , hazard rate , mean
residual life , and a nonparametric estimator.

- [`lt_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/lt_residual.md)
  : Univariate Laplace Transform of Residual Life
- [`hazard_rate()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/hazard_rate.md)
  : Univariate Hazard Rate Function
- [`mean_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/mean_residual.md)
  : Univariate Mean Residual Life
- [`np_lt_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/np_lt_residual.md)
  : Nonparametric Estimator for the Univariate Laplace Transform of
  Residual Life

## Stochastic Ordering (Bivariate)

Seven bivariate stochastic order checks: BLt-rl, BLt-Rrl, weak bivariate
hazard rate, MRL, bivariate relative MRL, reversed hazard rate, and
reversed MRL. Each function returns a logical flag and supporting
diagnostic values.

- [`blt_order_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_order_residual.md)
  : Bivariate Laplace Transform Order of Residual Lives (BLt-rl)
- [`blt_order_reversed()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_order_reversed.md)
  : Bivariate Laplace Transform Order of Reversed Residual Lives
  (BLt-Rrl)
- [`biv_whr_order()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_whr_order.md)
  : Weak Bivariate Hazard Rate Order
- [`biv_wmrl_order()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_wmrl_order.md)
  : Weak Bivariate Mean Residual Life Order
- [`biv_brlmr_order()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_brlmr_order.md)
  : Bivariate Relative Mean Residual Life Order
- [`biv_wrhr_order()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_wrhr_order.md)
  : Weak Bivariate Reversed Hazard Rate Order
- [`biv_wrmrl_order()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_wrmrl_order.md)
  : Weak Bivariate Reversed Mean Residual Life Order

## Stochastic Ordering (Univariate)

Three univariate stochastic order checks based on the Laplace transform
of residual life, hazard rate, and mean residual life.

- [`lt_rl_order()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/lt_rl_order.md)
  : Univariate Laplace Transform Order of Residual Lives
- [`hr_order()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/hr_order.md)
  : Hazard Rate Order
- [`mrl_order()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/mrl_order.md)
  : Mean Residual Life Order

## Entropy and Information Generating Functions

Shannon differential entropy and Golomb’s (1966) information generating
function for non-negative continuous random variables.

- [`shannon_entropy()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/shannon_entropy.md)
  : Shannon Differential Entropy
- [`info_gen_function()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/info_gen_function.md)
  : Golomb Information Generating Function

## Plotting Utilities

Convenience wrappers that produce ready-made plots for the BLT of
residual lives and the BLT of reversed residual lives.

- [`plot_blt_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/plot_blt_residual.md)
  : Plot Bivariate Laplace Transform of Residual Lives
- [`plot_blt_reversed()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/plot_blt_reversed.md)
  : Plot Bivariate Laplace Transform of Reversed Residual Lives

## Package

Package-level documentation and metadata.

- [`BivLaplaceRL-package`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/BivLaplaceRL-package.md)
  [`BivLaplaceRL`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/BivLaplaceRL-package.md)
  : BivLaplaceRL: Bivariate Laplace Transforms, Stochastic Orders, and
  Entropy Measures in Reliability
