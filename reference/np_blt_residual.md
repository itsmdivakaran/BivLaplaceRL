# Nonparametric Estimator for the Bivariate Laplace Transform of Residual Lives

Given a bivariate sample \\(X\_{1i}, X\_{2i}),\\ i=1,\ldots,n\\,
estimates \$\$\hat{L}^\*\_{1}(s_1; t_1, t_2) =
\frac{\sum\_{i:X\_{1i}\>t_1,\\X\_{2i}\>t_2} \int\_{t_1}^{X\_{1i}}
e^{-s_1 u}\\du}{e^{-s_1 t_1} \cdot \\\\X\_{1i}\>t_1,X\_{2i}\>t_2\\}\$\$
and analogously for the second component, using the empirical survival
function as described in Jayalekshmi et al. (2022), Section 6.

## Usage

``` r
np_blt_residual(data, s1, s2, t1 = 0, t2 = 0)
```

## Arguments

- data:

  A two-column numeric matrix or data frame with columns for \\X_1\\ and
  \\X_2\\.

- s1, s2:

  Positive Laplace parameters.

- t1, t2:

  Non-negative truncation ages.

## Value

A named numeric vector `(L1_hat, L2_hat)`.

## References

Jayalekshmi S., Rajesh G., Nair N.U. (2022), Section 6.
[doi:10.1080/03610926.2022.2085874](https://doi.org/10.1080/03610926.2022.2085874)

## See also

[`blt_residual_gumbel`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/blt_residual_gumbel.md),
[`sim_blt_residual`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/sim_blt_residual.md)

## Examples

``` r
set.seed(123)
dat <- rgumbel_biv(200, k1 = 1, k2 = 1, theta = 0.5)
np_blt_residual(dat, s1 = 1, s2 = 1, t1 = 0.3, t2 = 0.3)
#>    L1_hat    L2_hat 
#> 0.4975466 0.3895721 

# Compare with closed form
blt_residual_gumbel(s1 = 1, s2 = 1, t1 = 0.3, t2 = 0.3, theta = 0.5)
#>   L1_star   L2_star 
#> 0.4651163 0.4651163 
```
