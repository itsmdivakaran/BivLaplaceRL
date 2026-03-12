# Bivariate Laplace Transform Order of Residual Lives (BLt-rl)

Checks whether random vector \\X\\ is smaller than \\Y\\ in the
bivariate Laplace transform order of residual lives (BLt-rl).

\\X \le\_{\rm BLt\text{-}rl} Y\\ if and only if for all \\(t_1,t_2)\\ in
the support: \$\$\frac{\int\_{t_1}^\infty e^{-s_1
x_1}\bar{F}\_X(x_1,t_2)\\dx_1}{ e^{-s_1 t_1}\bar{F}\_X(t_1,t_2)} \ge
\frac{\int\_{t_1}^\infty e^{-s_1 x_1}\bar{F}\_Y(x_1,t_2)\\dx_1}{ e^{-s_1
t_1}\bar{F}\_Y(t_1,t_2)}\$\$ i.e.\\ \\L^\*\_{X\_{t_1\|t_2}}(s_1) \ge
L^\*\_{Y\_{t_1\|t_2}}(s_1)\\ for all \\t_1,t_2,s_1\\. The function
evaluates this inequality at a grid.

## Usage

``` r
blt_order_residual(
  surv_X,
  surv_Y,
  s1 = 1,
  s2 = 1,
  t1_grid = seq(0.1, 3, by = 0.5),
  t2_grid = seq(0.1, 3, by = 0.5),
  tol = 1e-06
)
```

## Arguments

- surv_X, surv_Y:

  Joint survival functions for \\X\\ and \\Y\\ respectively, each of the
  form `function(x1, x2)`.

- s1, s2:

  Laplace parameters to evaluate at.

- t1_grid, t2_grid:

  Grids of truncation times (default 0.1 to 3).

- tol:

  Tolerance for declaring inequality (default `1e-6`).

## Value

A list with elements:

- `order_holds`:

  Logical; `TRUE` if \\X \le Y\\ at all grid points.

- `violations`:

  Data frame of grid points where the ordering fails.

- `ratio_matrix`:

  Matrix of \\L^\*\_X / L^\*\_Y\\ values.

## References

Jayalekshmi S., Rajesh G., Nair N.U. (2022), Definition 4.1 & Prop. 4.1.
[doi:10.1080/03610926.2022.2085874](https://doi.org/10.1080/03610926.2022.2085874)

## See also

[`blt_residual`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_residual.md),
[`biv_whr_order`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/biv_whr_order.md)

## Examples

``` r
# Compare two Gumbel distributions
sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1, theta = 0.2)
sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 2, k2 = 2, theta = 0.2)
blt_order_residual(sX, sY, s1 = 1, s2 = 1,
                   t1_grid = c(0.1, 0.5, 1), t2_grid = c(0.1, 0.5))
#> $order_holds
#> [1] TRUE
#> 
#> $violations
#> [1] t1        t2        L1_star_X L1_star_Y
#> <0 rows> (or 0-length row.names)
#> 
#> $ratio_matrix
#>         t2=0.1  t2=0.5
#> t1=0.1 1.49505 1.47619
#> t1=0.5 1.49505 1.47619
#> t1=1   1.49505 1.47619
#> 
```
