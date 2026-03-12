# Weak Bivariate Mean Residual Life Order

Checks whether \\X \le\_{\rm wmrl} Y\\: \\m\_{i,X}(t_1,t_2) \le
m\_{i,Y}(t_1,t_2),\\ i=1,2\\.

## Usage

``` r
biv_wmrl_order(
  surv_X,
  surv_Y,
  t1_grid = seq(0.1, 2, by = 0.5),
  t2_grid = seq(0.1, 2, by = 0.5),
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

List with `order_holds` and `violations`.

## References

Jayalekshmi S., Rajesh G., Nair N.U. (2022).
[doi:10.1080/03610926.2022.2085874](https://doi.org/10.1080/03610926.2022.2085874)

## Examples

``` r
sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1.5, k2 = 1.5)
sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1)
biv_wmrl_order(sX, sY)
#> $order_holds
#> [1] TRUE
#> 
#> $violations
#> [1] t1   t2   m1_X m1_Y
#> <0 rows> (or 0-length row.names)
#> 
```
