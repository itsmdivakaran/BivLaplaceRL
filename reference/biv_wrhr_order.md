# Weak Bivariate Reversed Hazard Rate Order

Checks \\X \le\_{\rm wrhr} Y\\: the ratio \\F_X(x_1,x_2)/F_Y(x_1,x_2)\\
is decreasing in \\(x_1,x_2)\\, i.e.\\ \\h\_{i,X}(x_1,x_2) \le
h\_{i,Y}(x_1,x_2),\\ i=1,2\\.

## Usage

``` r
biv_wrhr_order(
  cdf_X,
  cdf_Y,
  x1_grid = seq(0.1, 0.9, by = 0.2),
  x2_grid = seq(0.1, 0.9, by = 0.2),
  tol = 1e-06
)
```

## Arguments

- cdf_X, cdf_Y:

  Joint CDFs.

- x1_grid, x2_grid:

  Evaluation grids (positive values).

- tol:

  Tolerance.

## Value

List with `order_holds` and `violations`.

## References

Jayalekshmi S., Rajesh G. — IJRQSE, Section 2.

## Examples

``` r
cX <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.2)
cY <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.5)
biv_wrhr_order(cX, cY)
#> $order_holds
#> [1] FALSE
#> 
#> $violations
#>        x1  x2     rh1_X     rh1_Y
#> rh1   0.1 0.1 9.8450897 9.6797103
#> rh11  0.1 0.3 9.8756611 9.7338353
#> rh12  0.1 0.5 9.9082519 9.7959134
#> rh13  0.1 0.7 9.9430690 9.8678364
#> rh14  0.1 0.9 9.9803486 9.9521481
#> rh15  0.3 0.1 3.1734749 2.9911275
#> rh16  0.3 0.3 3.2058282 3.0522083
#> rh17  0.3 0.5 3.2398748 3.1205668
#> rh18  0.3 0.7 3.2757512 3.1975862
#> rh19  0.3 0.9 3.3136089 3.2850236
#> rh110 0.5 0.1 1.8348622 1.6326529
#> rh111 0.5 0.3 1.8691587 1.7021275
#> rh112 0.5 0.5 1.9047617 1.7777776
#> rh113 0.5 0.7 1.9417474 1.8604649
#> rh114 0.5 0.9 1.9801978 1.9512193
#> rh115 0.7 0.1 1.2577933 1.0320956
#> rh116 0.7 0.3 1.2942143 1.1118292
#> rh117 0.7 0.5 1.3314839 1.1960132
#> rh118 0.7 0.7 1.3696322 1.2850307
#> rh119 0.7 0.9 1.4086906 1.3793102
#> rh120 0.9 0.1 0.9342938 0.6804890
#> rh121 0.9 0.3 0.9730440 0.7729468
#> rh122 0.9 0.5 1.0121011 0.8672086
#> rh123 0.9 0.7 1.0514689 0.9633278
#> rh124 0.9 0.9 1.0911510 1.0613598
#> 
```
