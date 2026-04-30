# Bivariate Power Distribution

Distribution function, survival function, density, and random generation
for the bivariate power distribution: \$\$F(x_1,x_2) = x_1^{p_1 + \theta
\log x_2}\\ x_2^{p_2},\quad 0 \le x_1,x_2 \le p_2,\\ p_1,p_2 \> 0,\\ 0
\le \theta \le 1.\$\$

## Usage

``` r
pbivpower(x1, x2, p1 = 1, p2 = 1, theta = 0)

sbivpower(x1, x2, p1 = 1, p2 = 1, theta = 0)

dbivpower(x1, x2, p1 = 1, p2 = 1, theta = 0)

rbivpower(n, p1 = 1, p2 = 1, theta = 0)
```

## Arguments

- x1, x2:

  Values in the support.

- p1, p2:

  Positive shape parameters.

- theta:

  Association parameter, \\0 \le \theta \le 1\\.

- n:

  Number of random observations.

## Value

Numeric vector or two-column matrix (`rbivpower`).

## References

Jayalekshmi S., Rajesh G. Bivariate Laplace transform order and ordering
of reversed residual lives. \*International Journal of Reliability,
Quality and Safety Engineering\*.

## Examples

``` r
pbivpower(0.4, 0.5, p1 = 2, p2 = 2, theta = 0.3)
#> [1] 0.04839598
set.seed(7); head(rbivpower(30, p1 = 2, p2 = 2, theta = 0.2))
#>             X1        X2
#> [1,] 0.8245284 0.9944392
#> [2,] 0.4972616 0.6306706
#> [3,] 0.3892548 0.3401438
#> [4,] 0.3780082 0.2640998
#> [5,] 0.5936128 0.4937098
#> [6,] 0.9194385 0.8899497
```
