# Closed-Form BLT of Reversed Residual Lives for the FGM Distribution

Computes the bivariate Laplace transform of the FGM distribution in
closed form (Jayalekshmi and Rajesh, Example 1): \$\$L_X(s_1,s_2) =
\frac{(1-e^{-s_1})(1-e^{-s_2})}{s_1 s_2} + \theta \Phi(s_1,s_2)\$\$
where \\\Phi\\ captures the dependence correction.

## Usage

``` r
blt_reversed_fgm(s1, s2, theta = 0)
```

## Arguments

- s1, s2:

  Positive Laplace parameters.

- theta:

  FGM association parameter, \\\|\theta\| \le 1\\.

## Value

Scalar numeric; the joint bivariate Laplace transform.

## References

Jayalekshmi S., Rajesh G. Bivariate Laplace transform order and ordering
of reversed residual lives. \*International Journal of Reliability,
Quality and Safety Engineering\*, Example 1.

## Examples

``` r
blt_reversed_fgm(s1 = 1, s2 = 1, theta = 0.5)
#> [1] 0.4344881
blt_reversed_fgm(s1 = 2, s2 = 0.5, theta = -0.3)
#> [1] 0.3241449
```
