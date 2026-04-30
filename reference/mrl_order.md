# Mean Residual Life Order

Checks whether \\X \leq\_{\rm mrl} Y\\ (mean residual life order): the
MRL of \\X\\ is pointwise no greater than that of \\Y\\: \$\$m_X(t) \leq
m_Y(t) \quad \forall\\ t \geq 0.\$\$

## Usage

``` r
mrl_order(surv_fn_X, surv_fn_Y, t_grid = seq(0, 3, by = 0.5), upper = 100)
```

## Arguments

- surv_fn_X, surv_fn_Y:

  Survival functions of \\X\\ and \\Y\\.

- t_grid:

  Grid of time points.

- upper:

  Integration upper bound.

## Value

A list with:

- `order_holds`:

  Logical.

- `max_violation`:

  Maximum of \\m_X(t) - m_Y(t)\\ over the grid.

- `mrl_X`:

  MRL of \\X\\ at `t_grid`.

- `mrl_Y`:

  MRL of \\Y\\ at `t_grid`.

## See also

[`mean_residual`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/mean_residual.md),
[`hr_order`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/hr_order.md),
[`lt_rl_order`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/lt_rl_order.md)

## Examples

``` r
# Exp(2) <=_mrl Exp(1): m_X(t)=0.5 <= 1=m_Y(t)
FbX <- function(x) pexp(x, 2, lower.tail = FALSE)
FbY <- function(x) pexp(x, 1, lower.tail = FALSE)
mrl_order(FbX, FbY, t_grid = c(0, 0.5, 1, 2))$order_holds
#> [1] TRUE
```
