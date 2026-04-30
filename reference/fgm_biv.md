# Farlie-Gumbel-Morgenstern (FGM) Bivariate Distribution

Density, distribution function, survival function, and random generation
for the FGM bivariate distribution on \\\[0,1\]^2\\: \$\$F(x_1, x_2) =
x_1 x_2 \bigl\[1 + \theta(1-x_1)(1-x_2)\bigr\], \quad 0 \le x_1, x_2 \le
1,\\ \|\theta\| \le 1.\$\$

## Usage

``` r
pfgm_biv(x1, x2, theta = 0)

dfgm_biv(x1, x2, theta = 0)

sfgm_biv(x1, x2, theta = 0)

rfgm_biv(n, theta = 0)
```

## Arguments

- x1, x2:

  Values in \\\[0,1\]\\.

- theta:

  Association parameter, \\\|\theta\| \le 1\\.

- n:

  Number of random observations.

## Value

Numeric vector (scalar functions) or two-column matrix (`rfgm_biv`).

## References

Jayalekshmi S., Rajesh G. Bivariate Laplace transform order and ordering
of reversed residual lives. \*International Journal of Reliability,
Quality and Safety Engineering\*.

## Examples

``` r
pfgm_biv(0.4, 0.6, theta = 0.5)
#> [1] 0.2688
dfgm_biv(0.4, 0.6, theta = 0.5)
#> [1] 0.98
set.seed(1); head(rfgm_biv(50, theta = 0.5))
#>             X1         X2
#> [1,] 0.2655087 0.40502512
#> [2,] 0.3721239 0.44331110
#> [3,] 0.5728534 0.53928902
#> [4,] 0.9082078 0.29699796
#> [5,] 0.2016819 0.07872567
#> [6,] 0.8983897 0.10625892
```
