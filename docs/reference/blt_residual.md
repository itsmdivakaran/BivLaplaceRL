# Bivariate Laplace Transform of Residual Lives

Computes the bivariate Laplace transform of residual lives
\\L\_{X\_{t_1\|t_2}}(s_1)\\ and \\L\_{X\_{t_2\|t_1}}(s_2)\\ defined as
\$\$L\_{X\_{t_1\|t_2}}(s_1) = \frac{\int\_{t_1}^{\infty} e^{-s_1 x_1}
f(x_1 \| X_2 \> t_2)\\dx_1}{e^{-s_1 t_1} \bar{F}(t_1 \| X_2 \> t_2)}\$\$
and analogously for the second component.

The \*star\* version (used for ordering) is
\$\$L^\*\_{X\_{t_1\|t_2}}(s_1) = \frac{1 - L\_{X\_{t_1\|t_2}}(s_1)}{s_1}
= \frac{\int\_{t_1}^{\infty} e^{-s_1 x_1} \bar{F}(x_1, t_2)}{e^{-s_1
t_1}\bar{F}(t_1,t_2)}\\dx_1.\$\$

## Usage

``` r
blt_residual(
  s1,
  s2,
  t1 = 0,
  t2 = 0,
  surv_fn = NULL,
  k1 = 1,
  k2 = 1,
  theta = 0,
  upper = 50,
  star = FALSE
)
```

## Arguments

- s1, s2:

  Positive Laplace parameters.

- t1, t2:

  Non-negative time thresholds (truncation ages).

- surv_fn:

  A function `function(x1, x2)` returning the joint survival probability
  \\\bar{F}(x_1, x_2)\\. Defaults to the Gumbel bivariate exponential
  with `k1`, `k2`, `theta`.

- k1, k2:

  Rate parameters (used only when `surv_fn = NULL`).

- theta:

  Association parameter (used only when `surv_fn = NULL`).

- upper:

  Integration upper bound (default `50`).

- star:

  Logical; if `TRUE` returns the star version \\L^\*\\.

## Value

A named numeric vector with elements `L1` and `L2` (or `L1_star` and
`L2_star` when `star = TRUE`).

## References

Jayalekshmi S., Rajesh G., Nair N.U. (2022).
[doi:10.1080/03610926.2022.2085874](https://doi.org/10.1080/03610926.2022.2085874)

## See also

[`blt_residual_gumbel`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_residual_gumbel.md),
[`blt_order_residual`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_order_residual.md),
[`np_blt_residual`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/np_blt_residual.md)

## Examples

``` r
# Gumbel bivariate exponential, default parameters
blt_residual(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5)
#>  L1  L2 
#> 0.5 0.5 

# Star version used in ordering
blt_residual(s1 = 0.5, s2 = 0.5, t1 = 1, t2 = 1, star = TRUE)
#>   L1_star   L2_star 
#> 0.6666667 0.6666667 

# User-supplied survival function (Schur-constant exponential)
surv <- function(x1, x2) exp(-(x1 + x2))
blt_residual(s1 = 1, s2 = 1, t1 = 0.3, t2 = 0.3, surv_fn = surv)
#>  L1  L2 
#> 0.5 0.5 
```
