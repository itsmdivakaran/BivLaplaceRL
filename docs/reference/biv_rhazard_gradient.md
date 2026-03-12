# Bivariate Reversed Hazard Gradient

Computes the bivariate reversed hazard gradient \$\$h_i(x_1,x_2) =
\frac{\partial}{\partial x_i}\log F(x_1,x_2), \quad i = 1, 2.\$\$

## Usage

``` r
biv_rhazard_gradient(x1, x2, cdf_fn = NULL, theta = 0, eps = 1e-07)
```

## Arguments

- x1, x2:

  Positive evaluation points.

- cdf_fn:

  Joint CDF function; defaults to FGM with parameter `theta`.

- theta:

  FGM parameter (used when `cdf_fn = NULL`).

- eps:

  Numerical differentiation step.

## Value

Named numeric vector `(rh1, rh2)`.

## References

Jayalekshmi S., Rajesh G. — IJRQSE, Section 2.

## Examples

``` r
biv_rhazard_gradient(x1 = 0.5, x2 = 0.5, theta = 0.3)
#>      rh1      rh2 
#> 1.860465 1.860465 
```
