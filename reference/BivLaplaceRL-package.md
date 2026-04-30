# BivLaplaceRL: Bivariate Laplace Transforms, Stochastic Orders, and Entropy Measures in Reliability

BivLaplaceRL provides a unified framework for reliability analysis
covering bivariate and univariate Laplace transforms of residual lives,
associated stochastic orders, and entropy measures:

**1. Bivariate Laplace Transform of Residual Lives**

Implements the vector Laplace transform of bivariate residual lives
\\(L\_{X\_{t_1\|t_2}}(s_1),\\L\_{X\_{t_2\|t_1}}(s_2))\\, the associated
stochastic ordering BLt-rl, and its relationships with the weak
bivariate hazard rate order, weak bivariate mean residual life order,
and bivariate relative mean residual life order. Nonparametric
estimation and NBUHR/NWUHR aging class tests are included. Reference:
Jayalekshmi, Rajesh, and Nair (2022)
[doi:10.1080/03610926.2022.2085874](https://doi.org/10.1080/03610926.2022.2085874)
.

**2. Bivariate Laplace Transform of Reversed Residual Lives**

Implements the bivariate Laplace transform of reversed (past) residual
lives, the BLt-Rrl stochastic order, and connections with weak bivariate
reversed hazard rate and reversed mean residual life orders. Reference:
Jayalekshmi, Rajesh, and Nair (2022)
[doi:10.1142/S0218539322500061](https://doi.org/10.1142/S0218539322500061)
.

**3. Univariate Residual Life Analysis**

Implements the univariate Laplace transform of residual life \\L_X(s,t)
= E\[e^{-sX} \mid X \> t\]\\, hazard rate, mean residual life, and the
corresponding stochastic orders (Lt-rl order, hazard rate order, MRL
order), together with a nonparametric estimator.

## Parametric families

Gumbel bivariate exponential, Farlie-Gumbel-Morgenstern (FGM), bivariate
power, and Schur-constant distributions are built in.

## Plotting

[`plot_blt_residual`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/plot_blt_residual.md)
and
[`plot_blt_reversed`](https://itsmdivakaran.github.io/BivLaplaceRL/reference/plot_blt_reversed.md)
provide ready-made visualisations.

## References

Jayalekshmi S., Rajesh G., Nair N.U. (2022). Bivariate Laplace transform
of residual lives and their properties. \*Communications in Statistics -
Theory and Methods\*.
[doi:10.1080/03610926.2022.2085874](https://doi.org/10.1080/03610926.2022.2085874)

Jayalekshmi S., Rajesh G., Nair N.U. (2022). Bivariate Laplace transform
order and ordering of reversed residual lives. \*International Journal
of Reliability, Quality and Safety Engineering\*.
[doi:10.1142/S0218539322500061](https://doi.org/10.1142/S0218539322500061)

Belzunce F., Ortega E., Ruiz J.M. (1999). The Laplace order and ordering
of residual lives. \*Statistics & Probability Letters\*, 42(2), 145–156.
[doi:10.1016/S0167-7152(98)00202-8](https://doi.org/10.1016/S0167-7152%2898%2900202-8)

Golomb S.W. (1966). The information generating function of a probability
distribution. \*IEEE Transactions on Information Theory\*, 12(1), 75–77.

## See also

Useful links:

- <https://itsmdivakaran.github.io/BivLaplaceRL/>

- <https://github.com/itsmdivakaran/BivLaplaceRL>

- Report bugs at <https://github.com/itsmdivakaran/BivLaplaceRL/issues>

## Author

**Maintainer**: Mahesh Divakaran <imaheshdivakaran@gmail.com>
([ORCID](https://orcid.org/0000-0002-3488-0857)) (Amity School of
Applied Sciences, Amity University Lucknow)

Authors:

- S. Jayalekshmi (Department of Statistics, Cochin University of Science
  and Technology) \[contributor\]

- G. Rajesh <rajeshgstat@gmail.com> (Department of Statistics, Cochin
  University of Science and Technology)

- N. Unnikrishnan Nair (Department of Statistics, Cochin University of
  Science and Technology)
