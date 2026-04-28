# BivLaplaceRL 0.2.0

## CRAN submission release

* Fixed CRAN review issues: corrected URLs, removed non-ASCII Unicode characters
  from Rd files, and updated `.Rbuildignore` exclusions.
* Added `WORDLIST` for spell-checking.
* Updated package documentation and metadata.

---

# BivLaplaceRL 0.1.0

## Initial release

* Added bivariate Laplace transform of residual lives:
  `blt_residual()`, `blt_residual_gumbel()`, `np_blt_residual()`,
  `sim_blt_residual()`.

* Added bivariate hazard gradient and mean residual life:
  `biv_hazard_gradient()`, `biv_mean_residual()`.

* Added NBUHR/NWUHR aging class test: `nbuhr_test()`.

* Added bivariate Laplace transform of reversed residual lives:
  `blt_reversed()`, `blt_reversed_fgm()`, `blt_reversed_power()`.

* Added reversed hazard gradient and reversed MRL:
  `biv_rhazard_gradient()`, `biv_rmrl()`.

* Added stochastic ordering functions:
  `blt_order_residual()`, `blt_order_reversed()`,
  `biv_whr_order()`, `biv_wmrl_order()`, `biv_brlmr_order()`,
  `biv_wrhr_order()`, `biv_wrmrl_order()`.

* Added entropy and information generating functions:
  `shannon_entropy()`, `info_gen_function()`, `residual_entropy()`,
  `residual_info_gen()`, `regf_profile()`, `regf_characterise()`,
  `np_residual_info_gen()`, `sim_regf()`.

* Added parametric distributions:
  Gumbel bivariate exponential, FGM, bivariate power, Schur-constant.

* Added plotting utilities:
  `plot_blt_residual()`, `plot_blt_reversed()`, `plot_regf()`.
