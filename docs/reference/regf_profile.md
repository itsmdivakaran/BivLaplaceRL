# REGF Profile Over Alpha

Evaluates
[`residual_info_gen`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/residual_info_gen.md)
over a grid of \\\alpha\\ values and optionally plots the result. Useful
for studying how the information content varies with the Renyi-type
parameter.

## Usage

``` r
regf_profile(
  dens_fn,
  surv_fn = NULL,
  alpha_grid = seq(0.1, 3, by = 0.2),
  t = 0,
  upper = 100,
  plot = FALSE
)
```

## Arguments

- dens_fn:

  Density function.

- surv_fn:

  Survival function; computed internally if `NULL`.

- alpha_grid:

  Numeric vector of \\\alpha\\ values (default 0.1 to 3).

- t:

  Truncation time.

- upper:

  Integration upper bound.

- plot:

  Logical; if `TRUE` plots the profile (default `FALSE`).

## Value

A data frame with columns `alpha` and `REGF`.

## Examples

``` r
f  <- function(x) dexp(x, 1)
Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
regf_profile(f, Fb, t = 0.5, plot = FALSE)
```
