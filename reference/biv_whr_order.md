# Weak Bivariate Hazard Rate Order

Checks whether \\X \le\_{\rm whr} Y\\: the ratio \\\bar{F}\_Y(x_1,x_2) /
\bar{F}\_X(x_1,x_2)\\ is increasing in \\(x_1,x_2)\\, i.e.\\
\\h\_{i,X}(t_1,t_2) \ge h\_{i,Y}(t_1,t_2),\\ i=1,2\\.

## Usage

``` r
biv_whr_order(
  surv_X,
  surv_Y,
  t1_grid = seq(0.1, 3, by = 0.5),
  t2_grid = seq(0.1, 3, by = 0.5),
  tol = 1e-06
)
```

## Arguments

- surv_X, surv_Y:

  Joint survival functions.

- t1_grid, t2_grid:

  Evaluation grids.

- tol:

  Tolerance.

## Value

A list: `order_holds` (logical), `violations` (data frame).

## References

Shaked M., Shanthikumar J.G. (2007). \*Stochastic Orders\*. Springer.
Jayalekshmi S., Rajesh G., Nair N.U. (2022).
[doi:10.1080/03610926.2022.2085874](https://doi.org/10.1080/03610926.2022.2085874)

## Examples

``` r
sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1, theta = 0)
sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 2, k2 = 2, theta = 0)
biv_whr_order(sX, sY)
#> $order_holds
#> [1] FALSE
#> 
#> $violations
#>       t1  t2 h1_X h1_Y
#> h1   0.1 0.1    1    2
#> h11  0.1 0.6    1    2
#> h12  0.1 1.1    1    2
#> h13  0.1 1.6    1    2
#> h14  0.1 2.1    1    2
#> h15  0.1 2.6    1    2
#> h16  0.6 0.1    1    2
#> h17  0.6 0.6    1    2
#> h18  0.6 1.1    1    2
#> h19  0.6 1.6    1    2
#> h110 0.6 2.1    1    2
#> h111 0.6 2.6    1    2
#> h112 1.1 0.1    1    2
#> h113 1.1 0.6    1    2
#> h114 1.1 1.1    1    2
#> h115 1.1 1.6    1    2
#> h116 1.1 2.1    1    2
#> h117 1.1 2.6    1    2
#> h118 1.6 0.1    1    2
#> h119 1.6 0.6    1    2
#> h120 1.6 1.1    1    2
#> h121 1.6 1.6    1    2
#> h122 1.6 2.1    1    2
#> h123 1.6 2.6    1    2
#> h124 2.1 0.1    1    2
#> h125 2.1 0.6    1    2
#> h126 2.1 1.1    1    2
#> h127 2.1 1.6    1    2
#> h128 2.1 2.1    1    2
#> h129 2.1 2.6    1    2
#> h130 2.6 0.1    1    2
#> h131 2.6 0.6    1    2
#> h132 2.6 1.1    1    2
#> h133 2.6 1.6    1    2
#> h134 2.6 2.1    1    2
#> h135 2.6 2.6    1    2
#> 
```
