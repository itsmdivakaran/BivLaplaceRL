# Univariate Mean Residual Life

Computes the mean residual life (mean excess function): \$\$m(t) =
E\[X - t \mid X \> t\] = \frac{1}{\bar{F}(t)}\int_t^\infty
\bar{F}(x)\\dx, \quad t \geq 0.\$\$

## Usage

``` r
mean_residual(surv_fn, t = 0, upper = 100)
```

## Arguments

- surv_fn:

  Survival function \\\bar{F}(x)\\.

- t:

  Scalar or numeric vector of time points.

- upper:

  Upper integration limit.

## Value

Numeric vector of MRL values at `t`.

## See also

[`hazard_rate`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/hazard_rate.md),
[`mrl_order`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/mrl_order.md)

## Examples

``` r
# Exp(1): constant MRL = 1 (memoryless)
Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
mean_residual(Fb, t = c(0, 0.5, 1, 2))
#> [1] 1 1 1 1

# Gamma(2,1): decreasing MRL
FbG <- function(x) pgamma(x, shape = 2, rate = 1, lower.tail = FALSE)
mean_residual(FbG, t = c(0, 0.5, 1, 2))
#> [1] 2.000000 1.666667 1.500000 1.333333
```
