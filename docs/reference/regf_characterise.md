# Characterise a Distribution via the REGF

Checks whether the functional form of \\\mathcal{I}\_\alpha(X;t)\\ over
a grid of \\t\\ values is consistent with an exponential distribution.
For \\X \sim \text{Exp}(\lambda)\\, \\\mathcal{I}\_\alpha(t) /
\mathcal{I}\_\alpha(0) = e^{(\alpha-1)\lambda t}\\, a pure exponential
in \\t\\.

## Usage

``` r
regf_characterise(
  dens_fn,
  surv_fn = NULL,
  alpha = 2,
  t_grid = seq(0, 2, by = 0.2),
  upper = 100
)
```

## Arguments

- dens_fn:

  Density function.

- surv_fn:

  Survival function.

- alpha:

  REGF parameter.

- t_grid:

  Grid of truncation times.

- upper:

  Integration upper bound.

## Value

A data frame with columns `t`, `REGF`, `log_REGF`, and the fitted
linear-in-\\t\\ slope `slope` (log-linear characterisation).

## References

Smitha S., Rajesh G., Jayalekshmi S. (2024), Section 3.

## Examples

``` r
f  <- function(x) dexp(x, 1)
Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
regf_characterise(f, Fb, alpha = 2)
#>      t REGF      log_REGF        slope
#> 1  0.0  0.5  0.000000e+00 1.312082e-16
#> 2  0.2  0.5 -4.440892e-16 1.312082e-16
#> 3  0.4  0.5 -1.221245e-15 1.312082e-16
#> 4  0.6  0.5  8.881784e-16 1.312082e-16
#> 5  0.8  0.5  6.661338e-16 1.312082e-16
#> 6  1.0  0.5  0.000000e+00 1.312082e-16
#> 7  1.2  0.5  1.110223e-15 1.312082e-16
#> 8  1.4  0.5 -3.330669e-16 1.312082e-16
#> 9  1.6  0.5  1.110223e-15 1.312082e-16
#> 10 1.8  0.5 -5.551115e-16 1.312082e-16
#> 11 2.0  0.5 -3.330669e-16 1.312082e-16
```
