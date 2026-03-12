# Plot Bivariate Laplace Transform of Reversed Residual Lives

Plots the reversed-life Laplace transform \\L\_{t_1\|t_2}(s_1)\\ as a
function of \\t_1\\ for fixed \\s_1\\ and \\t_2\\.

## Usage

``` r
plot_blt_reversed(
  cdf_fn,
  cdf_fn2 = NULL,
  s1 = 1,
  t2 = 0.5,
  t1_grid = seq(0.1, 0.9, by = 0.05),
  theta = 0,
  xlab = expression(t[1]),
  ylab = expression(L[t[1] * "|" * t[2]](s[1])),
  main = "Bivariate LT of Reversed Residual Lives",
  col1 = "darkgreen",
  col2 = "darkorange",
  lwd = 2,
  legend_labels = c("Distribution 1", "Distribution 2")
)
```

## Arguments

- cdf_fn:

  Joint CDF function.

- cdf_fn2:

  Optional second CDF for comparison.

- s1:

  Laplace parameter.

- t2:

  Fixed second truncation time.

- t1_grid:

  Grid of first truncation times.

- theta:

  FGM parameter (used if `cdf_fn = NULL`).

- xlab, ylab, main:

  Plot labels.

- col1, col2:

  Line colours.

- lwd:

  Line width.

- legend_labels:

  Legend labels.

## Value

Invisibly returns the data frame used for plotting.

## Examples

``` r
cX <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.2)
cY <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.7)
plot_blt_reversed(cX, cY, s1 = 1, t2 = 0.5,
                  legend_labels = c("theta=0.2", "theta=0.7"))

```
