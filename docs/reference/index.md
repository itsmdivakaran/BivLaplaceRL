# Package index

## Parametric Distributions

Gumbel bivariate exponential, FGM, bivariate power, and Schur-constant
distributions: density, CDF, survival function, and random generation.

- [`dgumbel_biv()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/gumbel_biv.md)
  [`sgumbel_biv()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/gumbel_biv.md)
  [`pgumbel_biv()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/gumbel_biv.md)
  [`rgumbel_biv()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/gumbel_biv.md)
  : Gumbel Bivariate Exponential Distribution
- [`pfgm_biv()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/fgm_biv.md)
  [`dfgm_biv()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/fgm_biv.md)
  [`sfgm_biv()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/fgm_biv.md)
  [`rfgm_biv()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/fgm_biv.md)
  : Farlie-Gumbel-Morgenstern (FGM) Bivariate Distribution
- [`pbivpower()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/bivpower.md)
  [`sbivpower()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/bivpower.md)
  [`dbivpower()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/bivpower.md)
  [`rbivpower()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/bivpower.md)
  : Bivariate Power Distribution
- [`sschur_biv()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/schur_biv.md)
  [`rschur_biv()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/schur_biv.md)
  : Schur-Constant Bivariate Distribution

## Bivariate Laplace Transform of Residual Lives

Functions for computing and testing the bivariate Laplace transform of
residual lives, including closed-form results for the Gumbel
distribution, nonparametric estimation, and the NBUHR/NWUHR aging class
test.

- [`blt_residual()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_residual.md)
  : Bivariate Laplace Transform of Residual Lives
- [`blt_residual_gumbel()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_residual_gumbel.md)
  : Closed-Form Bivariate Laplace Transform of Residual Lives (Gumbel)
- [`biv_hazard_gradient()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_hazard_gradient.md)
  : Bivariate Hazard Gradient
- [`biv_mean_residual()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_mean_residual.md)
  : Bivariate Mean Residual Life Function
- [`nbuhr_test()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/nbuhr_test.md)
  : Test NBUHR / NWUHR Aging Class
- [`np_blt_residual()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/np_blt_residual.md)
  : Nonparametric Estimator for the Bivariate Laplace Transform of
  Residual Lives
- [`sim_blt_residual()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/sim_blt_residual.md)
  : Monte-Carlo Simulation Study for the BLT Residual Estimator

## Bivariate Laplace Transform of Reversed Residual Lives

Functions for computing the bivariate Laplace transform of past
(reversed) residual lives, the reversed hazard gradient, and the
reversed MRL.

- [`blt_reversed()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_reversed.md)
  : Bivariate Laplace Transform of Reversed Residual Lives
- [`blt_reversed_fgm()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_reversed_fgm.md)
  : Closed-Form BLT of Reversed Residual Lives for the FGM Distribution
- [`blt_reversed_power()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_reversed_power.md)
  : Bivariate Laplace Transform of Reversed Residual Lives — Power
  Distribution
- [`biv_rhazard_gradient()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_rhazard_gradient.md)
  : Bivariate Reversed Hazard Gradient
- [`biv_rmrl()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_rmrl.md)
  : Bivariate Reversed Mean Residual Life Function

## Stochastic Ordering

Functions for checking bivariate stochastic orders: BLt-rl, BLt-Rrl,
weak bivariate hazard rate, MRL, reversed hazard rate, and reversed MRL
orders.

- [`blt_order_residual()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_order_residual.md)
  : Bivariate Laplace Transform Order of Residual Lives (BLt-rl)
- [`blt_order_reversed()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_order_reversed.md)
  : Bivariate Laplace Transform Order of Reversed Residual Lives
  (BLt-Rrl)
- [`biv_whr_order()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_whr_order.md)
  : Weak Bivariate Hazard Rate Order
- [`biv_wmrl_order()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_wmrl_order.md)
  : Weak Bivariate Mean Residual Life Order
- [`biv_brlmr_order()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_brlmr_order.md)
  : Bivariate Relative Mean Residual Life Order
- [`biv_wrhr_order()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_wrhr_order.md)
  : Weak Bivariate Reversed Hazard Rate Order
- [`biv_wrmrl_order()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_wrmrl_order.md)
  : Weak Bivariate Reversed Mean Residual Life Order

## Entropy and Information Generating Functions

Shannon entropy, Golomb information generating function, residual
entropy, and the residual entropy generating function (REGF) with
nonparametric estimation.

- [`shannon_entropy()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/shannon_entropy.md)
  : Shannon Differential Entropy
- [`info_gen_function()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/info_gen_function.md)
  : Golomb Information Generating Function
- [`residual_entropy()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/residual_entropy.md)
  : Residual Entropy Function
- [`residual_info_gen()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/residual_info_gen.md)
  : Residual Entropy Generating Function (REGF)
- [`regf_profile()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/regf_profile.md)
  : REGF Profile Over Alpha
- [`regf_characterise()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/regf_characterise.md)
  : Characterise a Distribution via the REGF
- [`np_residual_info_gen()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/np_residual_info_gen.md)
  : Nonparametric Estimator for the Residual Entropy Generating Function
- [`sim_regf()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/sim_regf.md)
  : Monte-Carlo Simulation for the REGF Nonparametric Estimator

## Plotting Utilities

Ready-made plots for Laplace transforms and entropy measures.

- [`plot_blt_residual()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/plot_blt_residual.md)
  : Plot Bivariate Laplace Transform of Residual Lives
- [`plot_blt_reversed()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/plot_blt_reversed.md)
  : Plot Bivariate Laplace Transform of Reversed Residual Lives
- [`plot_regf()`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/plot_regf.md)
  : Plot Residual Entropy Generating Function

## Package

- [`BivLaplaceRL-package`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/BivLaplaceRL-package.md)
  [`BivLaplaceRL`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/BivLaplaceRL-package.md)
  : BivLaplaceRL: Bivariate Laplace Transforms, Stochastic Orders, and
  Entropy Measures in Reliability
