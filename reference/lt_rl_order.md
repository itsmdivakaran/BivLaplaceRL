# Univariate Laplace Transform Order of Residual Lives

Checks whether \\X \leq\_{\rm Lt\text{-}rl} Y\\: the Laplace transform
of the residual life of \\X\\ is dominated by that of \\Y\\ pointwise
over a grid of \\(s, t)\\ values: \$\$L_X(s,t) \leq L_Y(s,t) \quad
\forall\\ s \geq 0,\\ t \geq 0.\$\$

The order is verified numerically on `s_grid` x `t_grid`.

## Usage

``` r
lt_rl_order(
  dens_fn_X,
  surv_fn_X = NULL,
  dens_fn_Y,
  surv_fn_Y = NULL,
  s_grid = seq(0.5, 3, by = 0.5),
  t_grid = seq(0, 2, by = 0.5),
  upper = 100
)
```

## Arguments

- dens_fn_X, dens_fn_Y:

  Density functions of \\X\\ and \\Y\\.

- surv_fn_X, surv_fn_Y:

  Survival functions; computed if `NULL`.

- s_grid:

  Numeric vector of Laplace parameter values to check.

- t_grid:

  Numeric vector of truncation times to check.

- upper:

  Integration upper bound.

## Value

A list with:

- `order_holds`:

  Logical; `TRUE` if the order holds at all grid points.

- `max_violation`:

  Maximum violation \\\max(L_X - L_Y, 0)\\.

- `ratio_matrix`:

  Matrix of \\L_X(s,t)/L_Y(s,t)\\ values (rows = `s_grid`, columns =
  `t_grid`).

## See also

[`lt_residual`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/lt_residual.md),
[`hr_order`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/hr_order.md),
[`mrl_order`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/mrl_order.md),
[`blt_order_residual`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_order_residual.md)

## Examples

``` r
# Exp(1) <=_Lt-rl Exp(2): L_{Exp(lambda)}(s,t) = lambda*exp(-s*t)/(s+lambda)
# For s>0: 1/(s+1) < 2/(s+2), so Exp(1) has smaller LT of residual life
fX  <- function(x) dexp(x, 1)
FbX <- function(x) pexp(x, 1, lower.tail = FALSE)
fY  <- function(x) dexp(x, 2)
FbY <- function(x) pexp(x, 2, lower.tail = FALSE)
lt_rl_order(fX, FbX, fY, FbY,
            s_grid = c(0.5, 1, 2), t_grid = c(0, 0.5, 1))$order_holds
#> [1] TRUE
```
