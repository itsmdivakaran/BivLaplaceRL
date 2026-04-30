# Gumbel Bivariate Exponential Distribution

Density, distribution (survival) function, and random generation for the
Gumbel bivariate exponential distribution with parameters \\k_1\\,
\\k_2\\, and association parameter \\\theta\\.

The joint survival function is \$\$\bar{F}(x_1,x_2) = \exp(-k_1 x_1 -
k_2 x_2 - \theta x_1 x_2), \quad x_1,x_2 \> 0,\\ k_1,k_2 \> 0,\\ 0 \le
\theta \le k_1 k_2.\$\$

## Usage

``` r
dgumbel_biv(x1, x2, k1 = 1, k2 = 1, theta = 0, log.p = FALSE)

sgumbel_biv(x1, x2, k1 = 1, k2 = 1, theta = 0, log.p = FALSE)

pgumbel_biv(x1, x2, k1 = 1, k2 = 1, theta = 0)

rgumbel_biv(n, k1 = 1, k2 = 1, theta = 0)
```

## Arguments

- x1, x2:

  Non-negative numeric values or vectors.

- k1, k2:

  Positive rate parameters.

- theta:

  Non-negative association parameter; must satisfy \\0 \le \theta \le
  k_1 k_2\\.

- log.p:

  Logical; if `TRUE` probabilities are given as \\\log(p)\\.

- n:

  Number of random observations.

## Value

- `dgumbel_biv`:

  Numeric vector of density values.

- `pgumbel_biv`:

  Numeric vector of joint CDF values.

- `sgumbel_biv`:

  Numeric vector of joint survival function values.

- `rgumbel_biv`:

  A two-column matrix with columns `X1` and `X2` containing the
  simulated observations.

## References

Gumbel E.J. (1960). Bivariate exponential distributions. \*Journal of
the American Statistical Association\*, 55(292), 698–707.

Jayalekshmi S., Rajesh G., Nair N.U. (2022).
[doi:10.1080/03610926.2022.2085874](https://doi.org/10.1080/03610926.2022.2085874)

## Examples

``` r
# Survival function
sgumbel_biv(1, 2, k1 = 1, k2 = 1, theta = 0.5)
#> [1] 0.01831564

# Density
dgumbel_biv(0.5, 0.5, k1 = 1, k2 = 1.5, theta = 0.3)
#> [1] 0.4246202

# Random sample
set.seed(42)
dat <- rgumbel_biv(100, k1 = 1, k2 = 1, theta = 0.5)
head(dat)
#>             X1        X2
#> [1,] 0.1983368 1.1562479
#> [2,] 0.6608953 0.2684703
#> [3,] 0.2834910 0.4831638
#> [4,] 0.0381919 1.8538458
#> [5,] 0.4731766 2.8787313
#> [6,] 1.4636271 0.2203317
```
