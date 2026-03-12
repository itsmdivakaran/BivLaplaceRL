# Monte-Carlo Simulation Study for the BLT Residual Estimator

Evaluates the performance of
[`np_blt_residual`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/np_blt_residual.md)
via repeated simulation from the Gumbel bivariate exponential
distribution and compares estimates to the closed-form
[`blt_residual_gumbel`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/blt_residual_gumbel.md)
values. Returns bias, variance, and mean squared error (MSE).

## Usage

``` r
sim_blt_residual(
  n_obs = 200,
  n_sim = 100,
  s1 = 1,
  s2 = 1,
  t1 = 0.3,
  t2 = 0.3,
  k1 = 1,
  k2 = 1,
  theta = 0.5,
  seed = 42L
)
```

## Arguments

- n_obs:

  Sample size per replicate.

- n_sim:

  Number of simulation replicates.

- s1, s2:

  Laplace parameters.

- t1, t2:

  Truncation ages.

- k1, k2, theta:

  Gumbel parameters.

- seed:

  Random seed for reproducibility.

## Value

A data frame with columns `component`, `true_value`, `mean_est`, `bias`,
`variance`, `mse`.

## References

Jayalekshmi S., Rajesh G., Nair N.U. (2022), Section 6.
[doi:10.1080/03610926.2022.2085874](https://doi.org/10.1080/03610926.2022.2085874)

## See also

[`np_blt_residual`](https://maheshdivakaran.github.io/BivLaplaceRL/reference/np_blt_residual.md)

## Examples

``` r
sim_blt_residual(n_obs = 100, n_sim = 50, s1 = 1, s2 = 1,
                 t1 = 0.3, t2 = 0.3, k1 = 1, k2 = 1, theta = 0.5)
#>         component true_value  mean_est         bias    variance         mse
#> L1_star   L1_star  0.4651163 0.4662491  0.001132807 0.002160922 0.002162206
#> L2_star   L2_star  0.4651163 0.3943240 -0.070792313 0.001744099 0.006755650
```
