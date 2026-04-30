# Nonparametric Estimator for the Univariate Laplace Transform of Residual Life

Given a sample \\X_1, \ldots, X_n\\, estimates the Laplace transform of
the residual life using the empirical survival function:
\$\$\hat{L}\_X(s,t) = \frac{\displaystyle\sum\_{i:\\X_i \> t} e^{-s
X_i}} {\\\\i : X_i \> t\\}.\$\$

## Usage

``` r
np_lt_residual(x, s, t = 0)
```

## Arguments

- x:

  Numeric vector; observed sample.

- s:

  Non-negative Laplace parameter.

- t:

  Truncation time (default 0).

## Value

Scalar numeric estimate of \\L_X(s,t)\\.

## See also

[`lt_residual`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/lt_residual.md)

## Examples

``` r
set.seed(1)
x <- rexp(300, rate = 1)

# Estimate at s=1, t=0: true value 1/(1+1) = 0.5
np_lt_residual(x, s = 1, t = 0)
#> [1] 0.483012

# Estimate at s=1, t=0.5: true value still approx 0.5 (memoryless)
np_lt_residual(x, s = 1, t = 0.5)
#> [1] 0.3168478
```
