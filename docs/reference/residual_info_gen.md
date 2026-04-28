# Residual Entropy Generating Function (REGF)

Computes the residual entropy generating function proposed by Smitha,
Rajesh, and Jayalekshmi (2024): \$\$\mathcal{I}\_\alpha(X; t) =
\int_t^\infty \left(\frac{f(x)}{\bar{F}(t)}\right)^\alpha dx, \quad
\alpha \> 0,\\ t \ge 0.\$\$

Note that:

- At \\t = 0\\, \\\mathcal{I}\_\alpha(X;0) = \mathcal{I}\_\alpha(f)\\,
  Golomb's IGF.

- \\-\partial \mathcal{I}\_\alpha/\partial\alpha\|\_{\alpha=1} =
  H(X;t)\\, the residual entropy.

## Usage

``` r
residual_info_gen(dens_fn, surv_fn = NULL, alpha = 1, t = 0, upper = 100)
```

## Arguments

- dens_fn:

  Density function \\f(x)\\.

- surv_fn:

  Survival function \\\bar{F}(x)\\; computed by integration if `NULL`.

- alpha:

  Positive parameter (default 1).

- t:

  Truncation time (default 0).

- upper:

  Upper integration limit.

## Value

Scalar numeric.

## References

Smitha S., Rajesh G., Jayalekshmi S. (2024). On residual entropy
generating function. \*Journal of the Indian Statistical Association\*,
62(1), 81–93.

## See also

[`info_gen_function`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/info_gen_function.md),
[`residual_entropy`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/residual_entropy.md),
[`np_residual_info_gen`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/np_residual_info_gen.md)

## Examples

``` r
f  <- function(x) dexp(x, 1)
Fb <- function(x) pexp(x, 1, lower.tail = FALSE)

# At t=0, alpha=1: should equal 1
residual_info_gen(f, Fb, alpha = 1, t = 0)
#> [1] 1

# Dynamic version at t = 0.5
residual_info_gen(f, Fb, alpha = 2, t = 0.5)
#> [1] 0.5

# Derivative recovers residual entropy
(residual_info_gen(f, Fb, alpha = 1 + 1e-5, t = 0) -
  residual_info_gen(f, Fb, alpha = 1, t = 0)) / 1e-5   # approx -H(f)
#> [1] -0.99999
```
