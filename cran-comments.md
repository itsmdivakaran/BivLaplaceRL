## Resubmission (0.3.0)

* Added univariate Laplace transform of residual life (`lt_residual()`),
  hazard rate (`hazard_rate()`), mean residual life (`mean_residual()`),
  nonparametric estimator (`np_lt_residual()`), and three univariate
  stochastic order checks (`lt_rl_order()`, `hr_order()`, `mrl_order()`).

## R CMD check results

0 errors | 0 warnings | 1 note

* All examples run in < 5 seconds.

* There are no calls to `globalVariables()`.

* The package does not use any compiled code (NeedsCompilation: no).

* The package has been tested on:
  - macOS (R release)
  - Windows (R release)
  - Ubuntu (R devel, release, oldrel-1)

## Notes

* "Possibly misspelled words in DESCRIPTION": The flagged words (BLt, Rrl,
  FGM, NBUHR, NWUHR, Golomb's, Farlie, Morgenstern, Schur, Jayalekshmi,
  Rajesh, rl, Lt) are either domain-specific abbreviations for reliability and
  stochastic order concepts, or surnames of cited authors. They are all spelled
  correctly.

* "unable to verify current time": Network connectivity issue on the checking
  machine; not a package problem.

## Downstream dependencies

None (new package).
