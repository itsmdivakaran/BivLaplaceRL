# Univariate Laplace Transform of Residual Life

Computes the Laplace transform of the residual life of a non-negative
continuous random variable conditioned on survival past time \\t\\:
\$\$L_X(s,t) = E\[e^{-sX} \mid X \> t\] =
\frac{1}{\bar{F}(t)}\int_t^\infty e^{-sx} f(x)\\dx, \quad s \geq 0,\\ t
\geq 0.\$\$

At \\t = 0\\ this reduces to the standard Laplace transform \\L_X(s) =
E\[e^{-sX}\]\\.

## Usage

``` r
lt_residual(dens_fn, surv_fn = NULL, s, t = 0, upper = 100)
```

## Arguments

- dens_fn:

  Density function \\f(x)\\.

- surv_fn:

  Survival function \\\bar{F}(x)\\; computed by numerical integration of
  `dens_fn` if `NULL`.

- s:

  Non-negative Laplace parameter.

- t:

  Truncation time (default 0).

- upper:

  Upper integration limit.

## Value

Scalar numeric.

## References

Belzunce F., Ortega E., Ruiz J.M. (1999). The Laplace order and ordering
of residual lives. \*Statistics & Probability Letters\*, 42(2), 145–156.

## See also

[`hazard_rate`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/hazard_rate.md),
[`mean_residual`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/mean_residual.md),
[`np_lt_residual`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/np_lt_residual.md),
[`lt_rl_order`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/lt_rl_order.md),
[`blt_residual`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_residual.md)

## Examples

``` r
# Exp(1): L_X(s, 0) = 1/(1+s) = 0.5 at s=1
f  <- function(x) dexp(x, 1)
Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
lt_residual(f, Fb, s = 1, t = 0)
#> [1] 0.5

# Memoryless property: L_X(s,t) should equal L_X(s,0) for Exp
lt_residual(f, Fb, s = 1, t = 0.5)
#> [1] 0.3032653
```
