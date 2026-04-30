# Univariate Hazard Rate Function

Computes the hazard rate (failure rate) of a non-negative continuous
random variable: \$\$h(t) = \frac{f(t)}{\bar{F}(t)}, \quad t \geq 0.\$\$

## Usage

``` r
hazard_rate(dens_fn, surv_fn = NULL, t, upper = 100)
```

## Arguments

- dens_fn:

  Density function \\f(t)\\.

- surv_fn:

  Survival function \\\bar{F}(t)\\; computed by numerical integration if
  `NULL`.

- t:

  Scalar or numeric vector of time points.

- upper:

  Upper integration limit (used only when `surv_fn = NULL`).

## Value

Numeric vector of hazard rates at `t`.

## See also

[`mean_residual`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/mean_residual.md),
[`hr_order`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/hr_order.md)

## Examples

``` r
# Exp(1): constant hazard rate = 1
f  <- function(x) dexp(x, 1)
Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
hazard_rate(f, Fb, t = c(0.5, 1, 2))
#> [1] 1 1 1

# Gamma(2,1): increasing hazard rate
fG  <- function(x) dgamma(x, shape = 2, rate = 1)
FbG <- function(x) pgamma(x, shape = 2, rate = 1, lower.tail = FALSE)
hazard_rate(fG, FbG, t = c(0.5, 1, 2))
#> [1] 0.3333333 0.5000000 0.6666667
```
