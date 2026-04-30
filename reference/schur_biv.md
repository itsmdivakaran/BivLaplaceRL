# Schur-Constant Bivariate Distribution

Random generation and survival function for a Schur-constant bivariate
distribution with survival function \$\$\bar{F}(x_1,x_2) = S(x_1 +
x_2),\quad x_1,x_2 \> 0,\$\$ where \\S\\ is a given univariate survival
function. The default marginal is exponential with rate `lambda`.

## Usage

``` r
sschur_biv(x1, x2, lambda = 1)

rschur_biv(n, lambda = 1)
```

## Arguments

- x1, x2:

  Non-negative values.

- lambda:

  Exponential rate parameter for the generating survival function.

- n:

  Number of random observations.

## Value

Numeric vector (`sschur_biv`) or two-column matrix (`rschur_biv`).

## References

Barlow R.E., Mendel M.B. (1992). De Finetti-type representations for
life distributions. \*Journal of the American Statistical Association\*,
87(420), 1116–1122.

## Examples

``` r
sschur_biv(0.5, 1, lambda = 1)
#> [1] 0.2231302
set.seed(2); head(rschur_biv(40, lambda = 1))
#>              X1         X2
#> [1,] 0.34448110 1.52087135
#> [2,] 0.07421996 0.33052811
#> [3,] 0.11079058 0.03586209
#> [4,] 0.49854778 1.23216194
#> [5,] 0.07769482 0.01183136
#> [6,] 0.26852149 0.39837614
```
