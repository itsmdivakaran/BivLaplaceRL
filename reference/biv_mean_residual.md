# Bivariate Mean Residual Life Function

Computes the bivariate mean residual life (MRL) function
\$\$m_1(t_1,t_2) = E(X\_{t_1\|t_2}) = \frac{\int\_{t_1}^{\infty}
\bar{F}(x_1,t_2)\\dx_1}{\bar{F}(t_1,t_2)}\$\$ and analogously
\\m_2(t_1,t_2)\\.

## Usage

``` r
biv_mean_residual(
  t1,
  t2,
  surv_fn = NULL,
  k1 = 1,
  k2 = 1,
  theta = 0,
  upper = 100
)
```

## Arguments

- t1, t2:

  Non-negative thresholds.

- surv_fn:

  Joint survival function; defaults to Gumbel bivariate exponential.

- k1, k2, theta:

  Gumbel parameters (used when `surv_fn = NULL`).

- upper:

  Upper integration bound (default `100`).

## Value

A named numeric vector `(m1, m2)`.

## References

Jayalekshmi S., Rajesh G., Nair N.U. (2022).
[doi:10.1080/03610926.2022.2085874](https://doi.org/10.1080/03610926.2022.2085874)

## Examples

``` r
biv_mean_residual(t1 = 0.5, t2 = 0.5)
#> m1 m2 
#>  1  1 
biv_mean_residual(t1 = 1, t2 = 0.5, k1 = 1, k2 = 2, theta = 0.2)
#>        m1        m2 
#> 0.9090909 0.4545455 
```
