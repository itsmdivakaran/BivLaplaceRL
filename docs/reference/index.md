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

## Stochastic Ordering

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

## Entropy and Information Generating Functions

Shannon entropy, Golomb information generating function, dynamic
residual entropy (Ebrahimi & Pellerey 1995), and the residual entropy
generating function (REGF) introduced in Smitha, Rajesh & Jayalekshmi
(2024, *JISA* 62(1)). Includes nonparametric estimation and a
Monte-Carlo simulator.

- [`shannon_entropy()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/shannon_entropy.md)
  : Shannon Differential Entropy
- [`info_gen_function()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/info_gen_function.md)
  : Golomb Information Generating Function
- [`residual_entropy()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/residual_entropy.md)
  : Residual Entropy Function
- [`residual_info_gen()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/residual_info_gen.md)
  : Residual Entropy Generating Function (REGF)
- [`regf_profile()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/regf_profile.md)
  : REGF Profile Over Alpha
- [`regf_characterise()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/regf_characterise.md)
  : Characterise a Distribution via the REGF
- [`np_residual_info_gen()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/np_residual_info_gen.md)
  : Nonparametric Estimator for the Residual Entropy Generating Function
- [`sim_regf()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/sim_regf.md)
  : Monte-Carlo Simulation for the REGF Nonparametric Estimator

## Plotting Utilities

Convenience wrappers that produce ready-made plots for the BLT of
residual lives, the BLT of reversed residual lives, and the REGF
profile.

- [`plot_blt_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/plot_blt_residual.md)
  : Plot Bivariate Laplace Transform of Residual Lives
- [`plot_blt_reversed()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/plot_blt_reversed.md)
  : Plot Bivariate Laplace Transform of Reversed Residual Lives
- [`plot_regf()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/plot_regf.md)
  : Plot Residual Entropy Generating Function

## Package

Package-level documentation and metadata.

- [`BivLaplaceRL-package`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/BivLaplaceRL-package.md)
  [`BivLaplaceRL`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/BivLaplaceRL-package.md)
  : BivLaplaceRL: Bivariate Laplace Transforms, Stochastic Orders, and
  Entropy Measures in Reliability
