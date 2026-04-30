# Bivariate Laplace Transform of Reversed Residual Lives

Computes the bivariate Laplace transform of reversed (past) residual
lives. For a random pair \\(X_1,X_2)\\ with joint distribution function
\\F(x_1,x_2)\\, the transform is \$\$L\_{t_1\|t_2}(s_1) = e^{-s_1 t_1} +
\frac{s_1 \int_0^{t_1} e^{-s_1 x_1} F(x_1, t_2)\\dx_1}{F(t_1, t_2)}\$\$
and the associated \\G\\ function (useful for ordering) is
\$\$G_1(t_1,t_2) = \frac{\int_0^{t_1} e^{-s_1 x_1} F(x_1, t_2)\\dx_1}{
e^{-s_1 t_1} F(t_1,t_2)}.\$\$

## Usage

``` r
blt_reversed(s1, s2, t1, t2, cdf_fn = NULL, theta = 0, g_form = FALSE)
```

## Arguments

- s1, s2:

  Positive Laplace parameters.

- t1, t2:

  Positive truncation times (\\t_i \> 0\\).

- cdf_fn:

  A function `function(x1, x2)` returning the joint CDF \\F(x_1,x_2)\\.
  Defaults to the FGM distribution.

- theta:

  FGM association parameter (used when `cdf_fn = NULL`).

- g_form:

  Logical; if `TRUE` returns the \\G\\ form instead of \\L\\.

## Value

A named numeric vector `(L1, L2)` or `(G1, G2)`.

## References

Jayalekshmi S., Rajesh G. Bivariate Laplace transform order and ordering
of reversed residual lives. \*International Journal of Reliability,
Quality and Safety Engineering\*.

## See also

[`blt_reversed_fgm`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_reversed_fgm.md),
[`blt_order_reversed`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_order_reversed.md)

## Examples

``` r
# FGM distribution (default)
blt_reversed(s1 = 1, s2 = 1, t1 = 0.6, t2 = 0.6)
#>        L1        L2 
#> 0.7519806 0.7519806 

# G form
blt_reversed(s1 = 1, s2 = 1, t1 = 0.6, t2 = 0.6, g_form = TRUE)
#>       G1       G2 
#> 0.370198 0.370198 

# User-supplied CDF
cdf <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.5)
blt_reversed(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5, cdf_fn = cdf)
#>       L1       L2 
#> 0.794195 0.794195 
```
