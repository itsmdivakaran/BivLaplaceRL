# Closed-Form Bivariate Laplace Transform of Residual Lives (Gumbel)

Returns the \*star\* bivariate Laplace transform of residual lives for
the Gumbel bivariate exponential distribution in closed form:
\$\$L^\*\_{X\_{t_1\|t_2}}(s_1) = \frac{1}{k_1 + s_1 + \theta t_2},\quad
L^\*\_{X\_{t_2\|t_1}}(s_2) = \frac{1}{k_2 + s_2 + \theta t_1}.\$\$

## Usage

``` r
blt_residual_gumbel(s1, s2, t1 = 0, t2 = 0, k1 = 1, k2 = 1, theta = 0)
```

## Arguments

- s1, s2:

  Positive Laplace parameters.

- t1, t2:

  Non-negative truncation ages.

- k1, k2:

  Positive rate parameters.

- theta:

  Non-negative association parameter.

## Value

A named numeric vector `(L1_star, L2_star)`.

## References

Jayalekshmi S., Rajesh G., Nair N.U. (2022), Example 3.1.
[doi:10.1080/03610926.2022.2085874](https://doi.org/10.1080/03610926.2022.2085874)

## See also

[`blt_residual`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_residual.md)

## Examples

``` r
blt_residual_gumbel(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5)
#> L1_star L2_star 
#>     0.5     0.5 
blt_residual_gumbel(s1 = 2, s2 = 0.5, t1 = 0, t2 = 1, k1 = 2, k2 = 1, theta = 0.3)
#>   L1_star   L2_star 
#> 0.2325581 0.6666667 
```
