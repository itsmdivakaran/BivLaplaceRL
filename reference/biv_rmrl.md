# Bivariate Reversed Mean Residual Life Function

Computes the bivariate reversed mean residual life (RMRL):
\$\$m_1(x_1,x_2) = \frac{\int_0^{x_1} F(t_1,x_2)\\dt_1}{F(x_1,x_2)},
\quad m_2(x_1,x_2) = \frac{\int_0^{x_2}
F(x_1,t_2)\\dt_2}{F(x_1,x_2)}.\$\$

## Usage

``` r
biv_rmrl(x1, x2, cdf_fn = NULL, theta = 0)
```

## Arguments

- x1, x2:

  Positive evaluation points.

- cdf_fn:

  Joint CDF; defaults to FGM.

- theta:

  FGM parameter.

## Value

Named numeric vector `(m1, m2)`.

## References

Jayalekshmi S., Rajesh G. — IJRQSE, Section 2.

## Examples

``` r
biv_rmrl(x1 = 0.5, x2 = 0.5, theta = 0.3)
#>       m1       m2 
#> 0.255814 0.255814 
biv_rmrl(x1 = 0.7, x2 = 0.4, theta = -0.2)
#>        m1        m2 
#> 0.3398340 0.1983402 
```
