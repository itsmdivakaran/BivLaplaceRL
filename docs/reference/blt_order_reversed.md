# Bivariate Laplace Transform Order of Reversed Residual Lives (BLt-Rrl)

Checks whether \\X \le\_{\rm BLt\text{-}Rrl} Y\\: for all \\(t_1,t_2)\\,
\\L^{X}\_{t_1\|t_2}(s_1) \ge L^{Y}\_{t_1\|t_2}(s_2)\\.

## Usage

``` r
blt_order_reversed(
  cdf_X,
  cdf_Y,
  s1 = 1,
  s2 = 1,
  t1_grid = seq(0.2, 0.8, by = 0.2),
  t2_grid = seq(0.2, 0.8, by = 0.2),
  tol = 1e-06
)
```

## Arguments

- cdf_X, cdf_Y:

  Joint CDF functions for \\X\\ and \\Y\\.

- s1, s2:

  Laplace parameters.

- t1_grid, t2_grid:

  Grids of truncation times.

- tol:

  Tolerance.

## Value

Same structure as
[`blt_order_residual`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_order_residual.md).

## References

Jayalekshmi S., Rajesh G. — IJRQSE, Definition 2.

## See also

[`blt_reversed`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_reversed.md),
[`biv_wrhr_order`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/biv_wrhr_order.md)

## Examples

``` r
cX <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.3)
cY <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.5)
blt_order_reversed(cX, cY, s1 = 1, s2 = 1,
                   t1_grid = c(0.2, 0.5), t2_grid = c(0.2, 0.5))
#> $order_holds
#> [1] FALSE
#> 
#> $violations
#>      t1  t2      L1_X      L1_Y
#> L1  0.2 0.2 0.9075620 0.9081760
#> L11 0.2 0.5 0.9071549 0.9076042
#> L12 0.5 0.2 0.7939358 0.7978231
#> L13 0.5 0.5 0.7914950 0.7941950
#> 
```
