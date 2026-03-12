# Weak Bivariate Reversed Mean Residual Life Order

Checks \\X \le\_{\rm wrmrl} Y\\: \\m\_{i,X}(x_1,x_2) \ge
m\_{i,Y}(x_1,x_2),\\ i=1,2\\.

## Usage

``` r
biv_wrmrl_order(
  cdf_X,
  cdf_Y,
  x1_grid = seq(0.2, 0.8, by = 0.2),
  x2_grid = seq(0.2, 0.8, by = 0.2),
  tol = 1e-06
)
```

## Arguments

- cdf_X, cdf_Y:

  Joint CDFs.

- x1_grid, x2_grid:

  Evaluation grids.

- tol:

  Tolerance.

## Value

List with `order_holds` and `violations`.

## References

Jayalekshmi S., Rajesh G. — IJRQSE, Section 2.

## Examples

``` r
cX <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.1)
cY <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.8)
biv_wrmrl_order(cX, cY)
#> $order_holds
#> [1] FALSE
#> 
#> $violations
#>       x1  x2      m1_X      m1_Y
#> m1   0.2 0.2 0.1005013 0.1028219
#> m11  0.2 0.4 0.1003817 0.1023121
#> m12  0.2 0.6 0.1002584 0.1016985
#> m13  0.2 0.8 0.1001312 0.1009456
#> m14  0.4 0.2 0.2020356 0.2123314
#> m15  0.4 0.4 0.2015444 0.2099379
#> m16  0.4 0.6 0.2010417 0.2071588
#> m17  0.4 0.8 0.2005270 0.2038929
#> m18  0.6 0.2 0.3046512 0.3305732
#> m19  0.6 0.4 0.3035156 0.3241611
#> m110 0.6 0.6 0.3023622 0.3170213
#> m111 0.6 0.8 0.3011905 0.3090226
#> m112 0.8 0.2 0.4083990 0.4605201
#> m113 0.8 0.4 0.4063241 0.4467153
#> m114 0.8 0.6 0.4042328 0.4320802
#> m115 0.8 0.8 0.4021248 0.4165375
#> 
```
