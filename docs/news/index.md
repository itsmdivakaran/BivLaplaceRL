# Changelog

## BivLaplaceRL 0.2.0

### CRAN submission release

- Fixed CRAN review issues: corrected URLs, removed non-ASCII Unicode
  characters from Rd files, and updated `.Rbuildignore` exclusions.
- Added `WORDLIST` for spell-checking.
- Updated package documentation and metadata.

------------------------------------------------------------------------

## BivLaplaceRL 0.1.0

### Initial release

- Added bivariate Laplace transform of residual lives:
  [`blt_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_residual.md),
  [`blt_residual_gumbel()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_residual_gumbel.md),
  [`np_blt_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/np_blt_residual.md),
  [`sim_blt_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/sim_blt_residual.md).

- Added bivariate hazard gradient and mean residual life:
  [`biv_hazard_gradient()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_hazard_gradient.md),
  [`biv_mean_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_mean_residual.md).

- Added NBUHR/NWUHR aging class test:
  [`nbuhr_test()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/nbuhr_test.md).

- Added bivariate Laplace transform of reversed residual lives:
  [`blt_reversed()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_reversed.md),
  [`blt_reversed_fgm()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_reversed_fgm.md),
  [`blt_reversed_power()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_reversed_power.md).

- Added reversed hazard gradient and reversed MRL:
  [`biv_rhazard_gradient()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_rhazard_gradient.md),
  [`biv_rmrl()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_rmrl.md).

- Added stochastic ordering functions:
  [`blt_order_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_order_residual.md),
  [`blt_order_reversed()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_order_reversed.md),
  [`biv_whr_order()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_whr_order.md),
  [`biv_wmrl_order()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_wmrl_order.md),
  [`biv_brlmr_order()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_brlmr_order.md),
  [`biv_wrhr_order()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_wrhr_order.md),
  [`biv_wrmrl_order()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_wrmrl_order.md).

- Added entropy and information generating functions:
  [`shannon_entropy()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/shannon_entropy.md),
  [`info_gen_function()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/info_gen_function.md),
  [`residual_entropy()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/residual_entropy.md),
  [`residual_info_gen()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/residual_info_gen.md),
  [`regf_profile()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/regf_profile.md),
  [`regf_characterise()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/regf_characterise.md),
  [`np_residual_info_gen()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/np_residual_info_gen.md),
  [`sim_regf()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/sim_regf.md).

- Added parametric distributions: Gumbel bivariate exponential, FGM,
  bivariate power, Schur-constant.

- Added plotting utilities:
  [`plot_blt_residual()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/plot_blt_residual.md),
  [`plot_blt_reversed()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/plot_blt_reversed.md),
  [`plot_regf()`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/plot_regf.md).
