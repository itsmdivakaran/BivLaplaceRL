# Hazard Rate Order

Checks whether \\X \leq\_{\rm hr} Y\\ (hazard rate order): the hazard
rate of \\X\\ is pointwise no greater than that of \\Y\\: \$\$h_X(t)
\leq h_Y(t) \quad \forall\\ t \geq 0.\$\$

Under this order \\X\\ is stochastically longer-lived than \\Y\\. For
exponential distributions, \\\mathrm{Exp}(\lambda_1) \leq\_{\rm hr}
\mathrm{Exp}(\lambda_2)\\ iff \\\lambda_1 \leq \lambda_2\\.

## Usage

``` r
hr_order(
  dens_fn_X,
  surv_fn_X = NULL,
  dens_fn_Y,
  surv_fn_Y = NULL,
  t_grid = seq(0.1, 3, by = 0.5),
  upper = 100
)
```

## Arguments

- dens_fn_X, dens_fn_Y:

  Density functions of \\X\\ and \\Y\\.

- surv_fn_X, surv_fn_Y:

  Survival functions; computed if `NULL`.

- t_grid:

  Grid of time points.

- upper:

  Integration upper bound.

## Value

A list with:

- `order_holds`:

  Logical.

- `max_violation`:

  Maximum of \\h_X(t) - h_Y(t)\\ over the grid.

- `hazard_X`:

  Hazard rate of \\X\\ at `t_grid`.

- `hazard_Y`:

  Hazard rate of \\Y\\ at `t_grid`.

## See also

[`hazard_rate`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/hazard_rate.md),
[`mrl_order`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/mrl_order.md),
[`lt_rl_order`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/lt_rl_order.md)

## Examples

``` r
# Exp(1) <=_hr Exp(2): h_X(t)=1 <= 2=h_Y(t)
fX  <- function(x) dexp(x, 1)
FbX <- function(x) pexp(x, 1, lower.tail = FALSE)
fY  <- function(x) dexp(x, 2)
FbY <- function(x) pexp(x, 2, lower.tail = FALSE)
hr_order(fX, FbX, fY, FbY, t_grid = c(0.5, 1, 2))$order_holds
#> [1] TRUE
```
