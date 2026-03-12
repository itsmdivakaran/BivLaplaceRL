# ==============================================================================
# Parametric Bivariate Distributions
# ==============================================================================

# ------------------------------------------------------------------------------
# Gumbel Bivariate Exponential
# ------------------------------------------------------------------------------

#' Gumbel Bivariate Exponential Distribution
#'
#' @description
#' Density, distribution (survival) function, and random generation for the
#' Gumbel bivariate exponential distribution with parameters \eqn{k_1},
#' \eqn{k_2}, and association parameter \eqn{\theta}.
#'
#' The joint survival function is
#' \deqn{\bar{F}(x_1,x_2) = \exp(-k_1 x_1 - k_2 x_2 - \theta x_1 x_2),
#'   \quad x_1,x_2 > 0,\; k_1,k_2 > 0,\; 0 \le \theta \le k_1 k_2.}
#'
#' @param x1,x2 Non-negative numeric values or vectors.
#' @param k1,k2 Positive rate parameters.
#' @param theta Non-negative association parameter; must satisfy
#'   \eqn{0 \le \theta \le k_1 k_2}.
#' @param n Number of random observations.
#' @param log.p Logical; if \code{TRUE} probabilities are given as
#'   \eqn{\log(p)}.
#'
#' @return
#' \describe{
#'   \item{\code{dgumbel_biv}}{Numeric vector of density values.}
#'   \item{\code{pgumbel_biv}}{Numeric vector of joint CDF values.}
#'   \item{\code{sgumbel_biv}}{Numeric vector of joint survival function values.}
#'   \item{\code{rgumbel_biv}}{A two-column matrix with columns \code{X1} and
#'     \code{X2} containing the simulated observations.}
#' }
#'
#' @examples
#' # Survival function
#' sgumbel_biv(1, 2, k1 = 1, k2 = 1, theta = 0.5)
#'
#' # Density
#' dgumbel_biv(0.5, 0.5, k1 = 1, k2 = 1.5, theta = 0.3)
#'
#' # Random sample
#' set.seed(42)
#' dat <- rgumbel_biv(100, k1 = 1, k2 = 1, theta = 0.5)
#' head(dat)
#'
#' @references
#' Gumbel E.J. (1960). Bivariate exponential distributions. *Journal of the
#' American Statistical Association*, 55(292), 698--707.
#'
#' Jayalekshmi S., Rajesh G., Nair N.U. (2022).
#' \doi{10.1080/03610926.2022.2085874}
#'
#' @name gumbel_biv
NULL

#' @rdname gumbel_biv
#' @export
dgumbel_biv <- function(x1, x2, k1 = 1, k2 = 1, theta = 0, log.p = FALSE) {
  .check_positive(k1, "k1"); .check_positive(k2, "k2")
  .check_nonneg(theta, "theta")
  if (theta > k1 * k2)
    stop("`theta` must be <= k1 * k2 = ", k1 * k2, ".")
  if (any(x1 < 0) || any(x2 < 0))
    stop("`x1` and `x2` must be non-negative.")

  log_d <- log(k1 + theta * x2) + log(k2 + theta * x1) +
    (-k1 * x1 - k2 * x2 - theta * x1 * x2) -
    log(1 + theta * x1 * x2 / ((k1 + theta * x2) * (k2 + theta * x1)))
  # Exact density: d/dx1 d/dx2 F(x1,x2) via survival function
  # f(x1,x2) = (k1 + theta*x2)(k2 + theta*x1) * exp(-k1*x1 - k2*x2 - theta*x1*x2)
  # minus theta * exp(-k1*x1 - k2*x2 - theta*x1*x2)  [cross term]
  log_d2 <- log(pmax(
    (k1 + theta * x2) * (k2 + theta * x1) - theta,
    .Machine$double.eps
  )) + (-k1 * x1 - k2 * x2 - theta * x1 * x2)

  if (log.p) return(log_d2)
  exp(log_d2)
}

#' @rdname gumbel_biv
#' @export
sgumbel_biv <- function(x1, x2, k1 = 1, k2 = 1, theta = 0, log.p = FALSE) {
  .check_positive(k1, "k1"); .check_positive(k2, "k2")
  .check_nonneg(theta, "theta")
  if (theta > k1 * k2)
    stop("`theta` must be <= k1 * k2 = ", k1 * k2, ".")
  log_s <- -k1 * x1 - k2 * x2 - theta * x1 * x2
  if (log.p) return(log_s)
  exp(log_s)
}

#' @rdname gumbel_biv
#' @export
pgumbel_biv <- function(x1, x2, k1 = 1, k2 = 1, theta = 0) {
  # P(X1 <= x1, X2 <= x2) via inclusion-exclusion on the survival function
  # F(x1,x2) = 1 - S(0,x2) - S(x1,0) + S(x1,x2)
  # = 1 - e^{-k2*x2} - e^{-k1*x1} + e^{-k1*x1-k2*x2-theta*x1*x2}
  1 - exp(-k1 * x1) - exp(-k2 * x2) +
    sgumbel_biv(x1, x2, k1, k2, theta)
}

#' @rdname gumbel_biv
#' @export
rgumbel_biv <- function(n, k1 = 1, k2 = 1, theta = 0) {
  .check_positive(k1, "k1"); .check_positive(k2, "k2")
  .check_nonneg(theta, "theta")
  # Conditional simulation: X1 ~ Exp(k1), X2|X1=x1 ~ Exp(k2 + theta*x1)
  x1 <- stats::rexp(n, rate = k1)
  x2 <- stats::rexp(n, rate = k2 + theta * x1)
  matrix(c(x1, x2), ncol = 2L, dimnames = list(NULL, c("X1", "X2")))
}

# ------------------------------------------------------------------------------
# Farlie-Gumbel-Morgenstern (FGM) Distribution
# ------------------------------------------------------------------------------

#' Farlie-Gumbel-Morgenstern (FGM) Bivariate Distribution
#'
#' @description
#' Density, distribution function, survival function, and random generation for
#' the FGM bivariate distribution on \eqn{[0,1]^2}:
#' \deqn{F(x_1, x_2) = x_1 x_2 \bigl[1 + \theta(1-x_1)(1-x_2)\bigr],
#'   \quad 0 \le x_1, x_2 \le 1,\; |\theta| \le 1.}
#'
#' @param x1,x2 Values in \eqn{[0,1]}.
#' @param theta Association parameter, \eqn{|\theta| \le 1}.
#' @param n Number of random observations.
#'
#' @return Numeric vector (scalar functions) or two-column matrix
#'   (\code{rfgm_biv}).
#'
#' @examples
#' pfgm_biv(0.4, 0.6, theta = 0.5)
#' dfgm_biv(0.4, 0.6, theta = 0.5)
#' set.seed(1); head(rfgm_biv(50, theta = 0.5))
#'
#' @references
#' Jayalekshmi S., Rajesh G. Bivariate Laplace transform order and ordering of
#' reversed residual lives. *International Journal of Reliability, Quality and
#' Safety Engineering*.
#'
#' @name fgm_biv
NULL

#' @rdname fgm_biv
#' @export
pfgm_biv <- function(x1, x2, theta = 0) {
  .check_range(theta, -1, 1, "theta")
  x1 * x2 * (1 + theta * (1 - x1) * (1 - x2))
}

#' @rdname fgm_biv
#' @export
dfgm_biv <- function(x1, x2, theta = 0) {
  .check_range(theta, -1, 1, "theta")
  1 + theta * (1 - 2 * x1) * (1 - 2 * x2)
}

#' @rdname fgm_biv
#' @export
sfgm_biv <- function(x1, x2, theta = 0) {
  # S(x1,x2) = 1 - x1 - x2 + F(x1,x2)
  1 - x1 - x2 + pfgm_biv(x1, x2, theta)
}

#' @rdname fgm_biv
#' @export
rfgm_biv <- function(n, theta = 0) {
  .check_range(theta, -1, 1, "theta")
  # Conditional distribution: X1 ~ Uniform(0,1)
  # X2|X1=u: solve F_{2|1}(x2|u) = v
  u  <- stats::runif(n)
  v  <- stats::runif(n)
  a  <- 1 + theta * (1 - 2 * u)
  b  <- -1
  cc <- v
  # a*x2^2 + b*x2 + cc = 0 => only root in [0,1]
  disc <- pmax(b^2 - 4 * a * cc, 0)
  x2 <- (-b - sqrt(disc)) / (2 * a)
  x2 <- pmin(pmax(x2, 0), 1)
  matrix(c(u, x2), ncol = 2L, dimnames = list(NULL, c("X1", "X2")))
}

# ------------------------------------------------------------------------------
# Bivariate Power Distribution
# ------------------------------------------------------------------------------

#' Bivariate Power Distribution
#'
#' @description
#' Distribution function, survival function, density, and random generation for
#' the bivariate power distribution:
#' \deqn{F(x_1,x_2) = x_1^{p_1 + \theta \log x_2}\,
#'   x_2^{p_2},\quad 0 \le x_1,x_2 \le p_2,\; p_1,p_2 > 0,\; 0 \le \theta \le 1.}
#'
#' @param x1,x2 Values in the support.
#' @param p1,p2 Positive shape parameters.
#' @param theta Association parameter, \eqn{0 \le \theta \le 1}.
#' @param n Number of random observations.
#'
#' @return Numeric vector or two-column matrix (\code{rbivpower}).
#'
#' @examples
#' pbivpower(0.4, 0.5, p1 = 2, p2 = 2, theta = 0.3)
#' set.seed(7); head(rbivpower(30, p1 = 2, p2 = 2, theta = 0.2))
#'
#' @references
#' Jayalekshmi S., Rajesh G. Bivariate Laplace transform order and ordering of
#' reversed residual lives. *International Journal of Reliability, Quality and
#' Safety Engineering*.
#'
#' @name bivpower
NULL

#' @rdname bivpower
#' @export
pbivpower <- function(x1, x2, p1 = 1, p2 = 1, theta = 0) {
  .check_positive(p1, "p1"); .check_positive(p2, "p2")
  .check_range(theta, 0, 1, "theta")
  x1^(p1 + theta * log(pmax(x2, .Machine$double.eps))) *
    x2^p2
}

#' @rdname bivpower
#' @export
sbivpower <- function(x1, x2, p1 = 1, p2 = 1, theta = 0) {
  # Survival function via inclusion-exclusion (marginals are power/uniform)
  # F_1(x1) = x1^p1, F_2(x2) = x2^p2 on [0,1]
  1 - x1^p1 - x2^p2 + pbivpower(x1, x2, p1, p2, theta)
}

#' @rdname bivpower
#' @export
dbivpower <- function(x1, x2, p1 = 1, p2 = 1, theta = 0) {
  .check_positive(p1, "p1"); .check_positive(p2, "p2")
  # d/dx1 d/dx2 F(x1,x2)
  alpha <- p1 + theta * log(pmax(x2, .Machine$double.eps))
  dbeta <- theta / pmax(x2, .Machine$double.eps)
  term1 <- alpha * (p2 + dbeta * x1 * log(pmax(x1, .Machine$double.eps))) *
    x1^(alpha - 1) * x2^(p2 - 1)
  term2 <- alpha * x1^(alpha - 1) * x2^p2 * dbeta
  term1 - term2
}

#' @rdname bivpower
#' @export
rbivpower <- function(n, p1 = 1, p2 = 1, theta = 0) {
  # Simple accept-reject or conditional simulation
  x2 <- stats::runif(n)^(1 / p2)
  alpha <- p1 + theta * log(pmax(x2, .Machine$double.eps))
  x1 <- stats::runif(n)^(1 / pmax(alpha, .Machine$double.eps))
  matrix(c(x1, x2), ncol = 2L, dimnames = list(NULL, c("X1", "X2")))
}

# ------------------------------------------------------------------------------
# Schur-Constant Distribution
# ------------------------------------------------------------------------------

#' Schur-Constant Bivariate Distribution
#'
#' @description
#' Random generation and survival function for a Schur-constant bivariate
#' distribution with survival function
#' \deqn{\bar{F}(x_1,x_2) = S(x_1 + x_2),\quad x_1,x_2 > 0,}
#' where \eqn{S} is a given univariate survival function.  The default marginal
#' is exponential with rate \code{lambda}.
#'
#' @param x1,x2 Non-negative values.
#' @param lambda Exponential rate parameter for the generating survival function.
#' @param n Number of random observations.
#'
#' @return Numeric vector (\code{sschur_biv}) or two-column matrix
#'   (\code{rschur_biv}).
#'
#' @examples
#' sschur_biv(0.5, 1, lambda = 1)
#' set.seed(2); head(rschur_biv(40, lambda = 1))
#'
#' @references
#' Barlow R.E., Mendel M.B. (1992). De Finetti-type representations for life
#' distributions. *Journal of the American Statistical Association*, 87(420),
#' 1116--1122.
#'
#' @name schur_biv
NULL

#' @rdname schur_biv
#' @export
sschur_biv <- function(x1, x2, lambda = 1) {
  .check_positive(lambda, "lambda")
  exp(-lambda * (x1 + x2))
}

#' @rdname schur_biv
#' @export
rschur_biv <- function(n, lambda = 1) {
  .check_positive(lambda, "lambda")
  # Dirichlet-like construction: (X1,X2) = (U*T, (1-U)*T) where T ~ Exp(lambda)
  T_  <- stats::rexp(n, rate = lambda)
  U   <- stats::runif(n)
  matrix(c(U * T_, (1 - U) * T_), ncol = 2L,
         dimnames = list(NULL, c("X1", "X2")))
}
