# Bivariate Hazard Gradient

Computes the bivariate hazard gradient \$\$h_i(t_1,t_2) =
-\frac{\partial}{\partial t_i}\log\bar{F}(t_1,t_2), \quad i = 1, 2.\$\$

## Usage

``` r
biv_hazard_gradient(
  t1,
  t2,
  surv_fn = NULL,
  k1 = 1,
  k2 = 1,
  theta = 0,
  eps = 1e-07
)
```

## Arguments

- t1, t2:

  Evaluation points (non-negative).

- surv_fn:

  A function `function(x1, x2)` returning the joint survival
  probability. Defaults to Gumbel bivariate exponential.

- k1, k2, theta:

  Parameters for the default Gumbel distribution.

- eps:

  Step size for numerical differentiation (default `1e-7`).

## Value

A named numeric vector `(h1, h2)`.

## References

Jayalekshmi S., Rajesh G., Nair N.U. (2022).
[doi:10.1080/03610926.2022.2085874](https://doi.org/10.1080/03610926.2022.2085874)

## Examples

``` r
biv_hazard_gradient(t1 = 1, t2 = 1)
#> h1 h2 
#>  1  1 
biv_hazard_gradient(t1 = 0.5, t2 = 0.5, k1 = 2, k2 = 1.5, theta = 0.3)
#>   h1   h2 
#> 2.15 1.65 
```
