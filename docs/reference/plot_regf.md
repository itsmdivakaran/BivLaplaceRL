# Plot Residual Entropy Generating Function

Plots the REGF \\\mathcal{I}\_\alpha(X;t)\\ as a function of \\t\\ for
given \\\alpha\\, or as a function of \\\alpha\\ for given \\t\\.

## Usage

``` r
plot_regf(
  dens_fn,
  surv_fn = NULL,
  alpha = 2,
  t = 0,
  grid = NULL,
  vary = c("t", "alpha"),
  upper = 100,
  col = "purple",
  lwd = 2,
  main = NULL
)
```

## Arguments

- dens_fn:

  Density function.

- surv_fn:

  Survival function; computed if `NULL`.

- alpha:

  Positive parameter (used when `vary = "t"`).

- t:

  Truncation time (used when `vary = "alpha"`).

- grid:

  Numeric vector of the varying quantity values.

- vary:

  One of `"t"` (plot as function of \\t\\) or `"alpha"` (plot as
  function of \\\alpha\\).

- upper:

  Integration upper bound.

- col:

  Line colour.

- lwd:

  Line width.

- main:

  Plot title.

## Value

Invisibly returns the data frame used for plotting.

## Examples

``` r
f  <- function(x) dexp(x, 1)
Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
plot_regf(f, Fb, alpha = 2, vary = "t")

plot_regf(f, Fb, t = 0.5, vary = "alpha")

```
