# Residual Entropy Function

Computes the residual entropy (dynamic entropy) introduced by Ebrahimi
and Pellerey (1995): \$\$H(X; t) = -\int_t^\infty
\frac{f(x)}{\bar{F}(t)} \log\frac{f(x)}{\bar{F}(t)}\\dx, \quad t \ge
0.\$\$

## Usage

``` r
residual_entropy(dens_fn, surv_fn = NULL, t = 0, upper = 100)
```

## Arguments

- dens_fn:

  Density function \\f(x)\\.

- surv_fn:

  Survival function \\\bar{F}(x)\\; if `NULL` it is computed from
  `dens_fn` by integration.

- t:

  Truncation time (default 0, which returns Shannon entropy).

- upper:

  Upper integration limit.

## Value

Scalar numeric.

## References

Ebrahimi N., Pellerey F. (1995). New partial ordering of survival
functions based on the notion of uncertainty. \*Journal of Applied
Probability\*, 32(1), 202–211.

## See also

[`residual_info_gen`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/residual_info_gen.md),
[`shannon_entropy`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/shannon_entropy.md)

## Examples

``` r
# Exponential(1)
f  <- function(x) dexp(x, 1)
Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
residual_entropy(f, Fb, t = 0)   # = 1
#> [1] 1
residual_entropy(f, Fb, t = 1)   # = 1 + exp(-1) * log(exp(1)-1) or similar
#> [1] 1
```
