# Nonparametric Estimator for the Residual Entropy Generating Function

Given a univariate sample \\X_1,\ldots,X_n\\, estimates the REGF using a
kernel density estimator for \\f\\ and the empirical survival function
for \\\bar{F}(t)\\: \$\$\hat{\mathcal{I}}\_\alpha(t) = \sum\_{i:X_i \>
t} \frac{\hat{f}(X_i)^{\alpha - 1}}{(n\\\hat{F}\_n(t))^\alpha} \cdot
\frac{1}{n}\$\$ where \\\hat{f}\\ is a Gaussian kernel density
estimator.

## Usage

``` r
np_residual_info_gen(x, alpha = 1, t = 0, bw = NULL)
```

## Arguments

- x:

  Numeric vector; observed sample.

- alpha:

  Positive parameter (default 1).

- t:

  Truncation time (default 0).

- bw:

  Bandwidth for KDE; uses
  [`bw.nrd0`](https://rdrr.io/r/stats/bandwidth.html) if `NULL`.

## Value

Scalar numeric estimate of REGF.

## References

Smitha S., Rajesh G., Jayalekshmi S. (2024), Section 4. \*Journal of the
Indian Statistical Association\*, 62(1), 81–93.

## See also

[`residual_info_gen`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/residual_info_gen.md),
[`sim_regf`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/sim_regf.md)

## Examples

``` r
set.seed(1)
x <- rexp(100, rate = 1)
np_residual_info_gen(x, alpha = 2, t = 0)
#> [1] 0.4341612

# Compare with true value
f  <- function(x) dexp(x, 1)
Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
residual_info_gen(f, Fb, alpha = 2, t = 0)
#> [1] 0.5
```
