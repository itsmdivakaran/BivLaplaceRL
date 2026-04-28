## Resubmission

* Fixed: Removed Unicode character `≈` (U+2248) from the `\examples{}` section
  of `residual_info_gen.Rd` (replaced with ASCII `approx`). This character
  caused a LaTeX error when building the PDF manual, resulting in 1 ERROR and
  1 WARNING in the previous submission.

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

* "Possibly misspelled words in DESCRIPTION": The flagged words (BLt, Rrl, FGM,
  NBUHR, NWUHR, Ebrahimi, Pellerey, Golomb's, Farlie, Morgenstern, Schur,
  Jayalekshmi, Rajesh, rl) are either domain-specific abbreviations for
  reliability and stochastic order concepts, or surnames of cited authors.
  They are all spelled correctly.

* "unable to verify current time": Network connectivity issue on the checking
  machine; not a package problem.

## Downstream dependencies

None (new package).
