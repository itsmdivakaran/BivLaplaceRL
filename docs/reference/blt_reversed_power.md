# Bivariate Laplace Transform of Reversed Residual Lives — Power Distribution

Computes the \\G_1\\ function for the bivariate power distribution:
\$\$G_1(t_1,t_2) = \frac{\int_0^{t_1} e^{-s_1 x_1} x_1^{p_1+\theta\log
t_2}\\dx_1}{e^{-s_1 t_1}\\ t_1^{p_1+\theta\log t_2}}\$\$ evaluated
numerically.

## Usage

``` r
blt_reversed_power(s1, t1, t2, p1 = 1, p2 = 1, theta = 0)
```

## Arguments

- s1:

  Positive Laplace parameter.

- t1, t2:

  Positive truncation times.

- p1, p2:

  Positive shape parameters.

- theta:

  Association parameter, \\0 \le \theta \le 1\\.

## Value

Named numeric vector `(G1, reversed_hazard_h1)`.

## References

Jayalekshmi S., Rajesh G. — IJRQSE, Example 2.

## Examples

``` r
blt_reversed_power(s1 = 1, t1 = 0.5, t2 = 0.5, p1 = 2, p2 = 2, theta = 0.3)
#>                 G1 reversed_hazard_h1 
#>         0.82154032        -0.06756347 
```
