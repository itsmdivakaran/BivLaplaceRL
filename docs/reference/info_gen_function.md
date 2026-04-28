# Golomb Information Generating Function

Computes the information generating function (IGF) introduced by Golomb
(1966): \$\$\mathcal{I}\_\alpha(f) = \int_0^\infty f^\alpha(x)\\dx,
\quad \alpha \> 0.\$\$

When \\\alpha \to 1\\, \\-d\mathcal{I}\_\alpha / d\alpha\|\_{\alpha=1} =
H(f)\\.

## Usage

``` r
info_gen_function(dens_fn, alpha = 1, upper = 100)
```

## Arguments

- dens_fn:

  A function of one argument returning the density.

- alpha:

  Positive parameter (default 1).

- upper:

  Upper integration limit.

## Value

Scalar numeric.

## References

Golomb S.W. (1966). The information generating function of a probability
distribution. \*IEEE Transactions on Information Theory\*, 12(1), 75–77.

## See also

[`residual_info_gen`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/residual_info_gen.md)

## Examples

``` r
# Exponential(1) with alpha=1 gives 1
info_gen_function(function(x) dexp(x, rate = 1), alpha = 1)
#> [1] 1

# alpha = 2
info_gen_function(function(x) dexp(x, rate = 1), alpha = 2)
#> [1] 0.5
```
