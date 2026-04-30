# Bivariate Relative Mean Residual Life Order

Checks whether \\X \le\_{\rm brlmr} Y\\: the ratio \\m\_{i,Y}(t_1,t_2) /
m\_{i,X}(t_1,t_2)\\ is increasing in \\t_i\\.

## Usage

``` r
biv_brlmr_order(
  surv_X,
  surv_Y,
  t2_fixed = 0.5,
  t1_grid = seq(0.2, 3, by = 0.3),
  tol = 1e-06
)
```

## Arguments

- surv_X, surv_Y:

  Joint survival functions.

- t2_fixed:

  Fixed value of \\t_2\\ for the univariate slices.

- t1_grid:

  Grid of \\t_1\\ values.

- tol:

  Tolerance.

## Value

List with `order_holds` and `ratio_values`.

## References

Kayid M., Izadkhah S., Alshami S. (2016). Residual probability function,
associated orderings, and related aging classes. \*Statistics and
Probability Letters\*, 116, 37–47.

## Examples

``` r
sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 2, k2 = 1)
sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1)
biv_brlmr_order(sX, sY, t2_fixed = 0.5)
#> $order_holds
#> [1] TRUE
#> 
#> $ratio_values
#>  [1] 2 2 2 2 2 2 2 2 2 2
#> 
#> $t1_grid
#>  [1] 0.2 0.5 0.8 1.1 1.4 1.7 2.0 2.3 2.6 2.9
#> 
```
