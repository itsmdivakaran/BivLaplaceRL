# Shannon Differential Entropy

Computes the Shannon differential entropy \$\$H(f) = -\int_0^\infty
f(x)\log f(x)\\dx\$\$ for a non-negative continuous random variable with
density `dens_fn`.

## Usage

``` r
shannon_entropy(dens_fn, upper = 100)
```

## Arguments

- dens_fn:

  A function of one argument returning the density \\f(x)\\.

- upper:

  Upper integration limit (default 100).

## Value

Scalar numeric.

## References

Shannon C.E. (1948). A mathematical theory of communication. \*Bell
System Technical Journal\*, 27(3), 379–423.

Smitha S., Rajesh G., Jayalekshmi S. (2024). \*Journal of the Indian
Statistical Association\*, 62(1), 81–93.

## See also

[`residual_entropy`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/residual_entropy.md),
[`info_gen_function`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/info_gen_function.md)

## Examples

``` r
# Exponential(1): H = 1
shannon_entropy(function(x) dexp(x, rate = 1))
#> [1] 1

# Exponential(2): H = 1 - log(2)
shannon_entropy(function(x) dexp(x, rate = 2))
#> [1] 0.3068528
```
