# Test NBUHR / NWUHR Aging Class

Checks whether a bivariate lifetime distribution belongs to the NBUHR
(New Better than Used in Hazard Rate) or NWUHR (New Worse than Used)
aging class. A distribution is NBUHR if \$\$h_1(0,t_2) \ge
h_1(t_1,t_2)\\\text{ for all }t_1 \> 0\$\$ and similarly for the second
component. The function evaluates this at a grid of \\t_1\\ values.

## Usage

``` r
nbuhr_test(
  t2 = 1,
  t1_grid = seq(0.1, 5, by = 0.1),
  surv_fn = NULL,
  k1 = 1,
  k2 = 1,
  theta = 0
)
```

## Arguments

- t2:

  Fixed value of the second age coordinate.

- t1_grid:

  Numeric vector of \\t_1\\ values to check (default 0.1 to 5 in steps
  of 0.1).

- surv_fn:

  Joint survival function; defaults to Gumbel bivariate exponential.

- k1, k2, theta:

  Gumbel parameters.

## Value

A list with components:

- `class1`:

  Character: `"NBUHR"`, `"NWUHR"`, or `"neither"` for the first
  component.

- `class2`:

  Same for the second component.

- `h1_grid`:

  Numeric vector of \\h_1(t_1,t_2)\\ values.

- `h2_grid`:

  Numeric vector of \\h_2(t_1,t_2)\\ values.

## References

Jayalekshmi S., Rajesh G., Nair N.U. (2022), Definition 3.2.
[doi:10.1080/03610926.2022.2085874](https://doi.org/10.1080/03610926.2022.2085874)

## Examples

``` r
nbuhr_test(t2 = 1, k1 = 1, k2 = 1, theta = 0.3)
#> $class1
#> [1] "neither"
#> 
#> $class2
#> [1] "NWUHR"
#> 
#> $h1_grid
#>  [1] 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3
#> [20] 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3
#> [39] 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3
#> 
#> $h2_grid
#>  [1] 1.03 1.06 1.09 1.12 1.15 1.18 1.21 1.24 1.27 1.30 1.33 1.36 1.39 1.42 1.45
#> [16] 1.48 1.51 1.54 1.57 1.60 1.63 1.66 1.69 1.72 1.75 1.78 1.81 1.84 1.87 1.90
#> [31] 1.93 1.96 1.99 2.02 2.05 2.08 2.11 2.14 2.17 2.20 2.23 2.26 2.29 2.32 2.35
#> [46] 2.38 2.41 2.44 2.47 2.50
#> 
#> $t1_grid
#>  [1] 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9
#> [20] 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8
#> [39] 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0
#> 
nbuhr_test(t2 = 0.5,
           surv_fn = function(x1, x2) exp(-(x1 + x2)))
#> $class1
#> [1] "neither"
#> 
#> $class2
#> [1] "neither"
#> 
#> $h1_grid
#>  [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#> [39] 1 1 1 1 1 1 1 1 1 1 1 1
#> 
#> $h2_grid
#>  [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#> [39] 1 1 1 1 1 1 1 1 1 1 1 1
#> 
#> $t1_grid
#>  [1] 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9
#> [20] 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8
#> [39] 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0
#> 
```
