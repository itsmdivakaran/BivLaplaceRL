# ==============================================================================
# Bivariate Laplace Transform of Residual Lives
# Reference: Jayalekshmi, Rajesh, Nair (2022) doi:10.1080/03610926.2022.2085874
# ==============================================================================

# ------------------------------------------------------------------------------
# Core transform
# ------------------------------------------------------------------------------

#' Bivariate Laplace Transform of Residual Lives
#'
#' @description
#' Computes the bivariate Laplace transform of residual lives
#' \eqn{L_{X_{t_1|t_2}}(s_1)} and \eqn{L_{X_{t_2|t_1}}(s_2)} defined as
#' \deqn{L_{X_{t_1|t_2}}(s_1)
#'   = \frac{\int_{t_1}^{\infty} e^{-s_1 x_1}
#'     f(x_1 | X_2 > t_2)\,dx_1}{e^{-s_1 t_1} \bar{F}(t_1 | X_2 > t_2)}}
#' and analogously for the second component.
#'
#' The *star* version (used for ordering) is
#' \deqn{L^*_{X_{t_1|t_2}}(s_1) = \frac{1 - L_{X_{t_1|t_2}}(s_1)}{s_1}
#'   = \frac{\int_{t_1}^{\infty} e^{-s_1 x_1}
#'     \bar{F}(x_1, t_2)}{e^{-s_1 t_1}\bar{F}(t_1,t_2)}\,dx_1.}
#'
#' @param s1,s2 Positive Laplace parameters.
#' @param t1,t2 Non-negative time thresholds (truncation ages).
#' @param surv_fn A function \code{function(x1, x2)} returning the joint
#'   survival probability \eqn{\bar{F}(x_1, x_2)}.  Defaults to the
#'   Gumbel bivariate exponential with \code{k1}, \code{k2}, \code{theta}.
#' @param k1,k2 Rate parameters (used only when \code{surv_fn = NULL}).
#' @param theta Association parameter (used only when \code{surv_fn = NULL}).
#' @param upper Integration upper bound (default \code{50}).
#' @param star Logical; if \code{TRUE} returns the star version \eqn{L^*}.
#'
#' @return A named numeric vector with elements \code{L1} and \code{L2}
#'   (or \code{L1_star} and \code{L2_star} when \code{star = TRUE}).
#'
#' @examples
#' # Gumbel bivariate exponential, default parameters
#' blt_residual(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5)
#'
#' # Star version used in ordering
#' blt_residual(s1 = 0.5, s2 = 0.5, t1 = 1, t2 = 1, star = TRUE)
#'
#' # User-supplied survival function (Schur-constant exponential)
#' surv <- function(x1, x2) exp(-(x1 + x2))
#' blt_residual(s1 = 1, s2 = 1, t1 = 0.3, t2 = 0.3, surv_fn = surv)
#'
#' @references
#' Jayalekshmi S., Rajesh G., Nair N.U. (2022).
#' \doi{10.1080/03610926.2022.2085874}
#'
#' @seealso \code{\link{blt_residual_gumbel}}, \code{\link{blt_order_residual}},
#'   \code{\link{np_blt_residual}}
#' @export
blt_residual <- function(s1, s2, t1 = 0, t2 = 0,
                          surv_fn = NULL,
                          k1 = 1, k2 = 1, theta = 0,
                          upper = 50,
                          star = FALSE) {
  .check_positive(s1, "s1"); .check_positive(s2, "s2")
  .check_nonneg(t1, "t1");   .check_nonneg(t2, "t2")

  if (is.null(surv_fn))
    surv_fn <- function(x1, x2) sgumbel_biv(x1, x2, k1, k2, theta)

  Ft1t2 <- surv_fn(t1, t2)
  if (Ft1t2 <= 0) stop("surv_fn(t1, t2) = 0; support exceeded.")

  if (!star) {
    # L1 = int_{t1}^{infty} e^{-s1*x1} f(x1|X2>t2) dx1
    #    = numerator / (e^{-s1*t1} * S(t1|X2>t2))
    # Numerically: e^{-s1*x1} * f(x1|X2>t2) integrand
    # f(x1|X2>t2) = -d/dx1 S(x1,t2) / S_2(t2)    [not needed with ratio form]
    # Use: L1 = int_{t1}^{infty} e^{-s1*x1} * (-d/dx1 S(x1,t2)/S(t1,t2)) dx1
    eps <- 1e-8
    f1 <- function(x1) {
      dSdx1 <- (surv_fn(x1, t2) - surv_fn(x1 + eps, t2)) / eps
      exp(-s1 * x1) * dSdx1 / Ft1t2
    }
    num1 <- .integrate1d(f1, t1, upper)
    L1   <- num1 / exp(-s1 * t1)

    f2 <- function(x2) {
      dSdx2 <- (surv_fn(t1, x2) - surv_fn(t1, x2 + eps)) / eps
      exp(-s2 * x2) * dSdx2 / Ft1t2
    }
    num2 <- .integrate1d(f2, t2, upper)
    L2   <- num2 / exp(-s2 * t2)

    c(L1 = L1, L2 = L2)
  } else {
    # L*1 = int_{t1}^{infty} e^{-s1*x1} * S(x1,t2) dx1 / (e^{-s1*t1} * S(t1,t2))
    f1star <- function(x1) exp(-s1 * x1) * surv_fn(x1, t2)
    num1   <- .integrate1d(f1star, t1, upper)
    L1star <- num1 / (exp(-s1 * t1) * Ft1t2)

    f2star <- function(x2) exp(-s2 * x2) * surv_fn(t1, x2)
    num2   <- .integrate1d(f2star, t2, upper)
    L2star <- num2 / (exp(-s2 * t2) * Ft1t2)

    c(L1_star = L1star, L2_star = L2star)
  }
}

# ------------------------------------------------------------------------------
# Closed-form: Gumbel bivariate exponential
# ------------------------------------------------------------------------------

#' Closed-Form Bivariate Laplace Transform of Residual Lives (Gumbel)
#'
#' @description
#' Returns the *star* bivariate Laplace transform of residual lives for the
#' Gumbel bivariate exponential distribution in closed form:
#' \deqn{L^*_{X_{t_1|t_2}}(s_1) = \frac{1}{k_1 + s_1 + \theta t_2},\quad
#'   L^*_{X_{t_2|t_1}}(s_2) = \frac{1}{k_2 + s_2 + \theta t_1}.}
#'
#' @param s1,s2 Positive Laplace parameters.
#' @param t1,t2 Non-negative truncation ages.
#' @param k1,k2 Positive rate parameters.
#' @param theta Non-negative association parameter.
#'
#' @return A named numeric vector \code{(L1_star, L2_star)}.
#'
#' @examples
#' blt_residual_gumbel(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5)
#' blt_residual_gumbel(s1 = 2, s2 = 0.5, t1 = 0, t2 = 1, k1 = 2, k2 = 1, theta = 0.3)
#'
#' @references
#' Jayalekshmi S., Rajesh G., Nair N.U. (2022), Example 3.1.
#' \doi{10.1080/03610926.2022.2085874}
#'
#' @seealso \code{\link{blt_residual}}
#' @export
blt_residual_gumbel <- function(s1, s2, t1 = 0, t2 = 0,
                                 k1 = 1, k2 = 1, theta = 0) {
  .check_positive(s1, "s1"); .check_positive(s2, "s2")
  .check_nonneg(t1, "t1");   .check_nonneg(t2, "t2")
  .check_positive(k1, "k1"); .check_positive(k2, "k2")
  .check_nonneg(theta, "theta")

  L1 <- 1 / (k1 + s1 + theta * t2)
  L2 <- 1 / (k2 + s2 + theta * t1)
  c(L1_star = L1, L2_star = L2)
}

# ------------------------------------------------------------------------------
# Bivariate hazard gradient
# ------------------------------------------------------------------------------

#' Bivariate Hazard Gradient
#'
#' @description
#' Computes the bivariate hazard gradient
#' \deqn{h_i(t_1,t_2) = -\frac{\partial}{\partial t_i}\log\bar{F}(t_1,t_2),
#'   \quad i = 1, 2.}
#'
#' @param t1,t2 Evaluation points (non-negative).
#' @param surv_fn A function \code{function(x1, x2)} returning the joint
#'   survival probability.  Defaults to Gumbel bivariate exponential.
#' @param k1,k2,theta Parameters for the default Gumbel distribution.
#' @param eps Step size for numerical differentiation (default \code{1e-7}).
#'
#' @return A named numeric vector \code{(h1, h2)}.
#'
#' @examples
#' biv_hazard_gradient(t1 = 1, t2 = 1)
#' biv_hazard_gradient(t1 = 0.5, t2 = 0.5, k1 = 2, k2 = 1.5, theta = 0.3)
#'
#' @references
#' Jayalekshmi S., Rajesh G., Nair N.U. (2022).
#' \doi{10.1080/03610926.2022.2085874}
#'
#' @export
biv_hazard_gradient <- function(t1, t2,
                                 surv_fn = NULL,
                                 k1 = 1, k2 = 1, theta = 0,
                                 eps = 1e-7) {
  .check_nonneg(t1, "t1"); .check_nonneg(t2, "t2")
  if (is.null(surv_fn))
    surv_fn <- function(x1, x2) sgumbel_biv(x1, x2, k1, k2, theta)

  log_S <- function(x1, x2) .safe_log(surv_fn(x1, x2))
  h1 <- -(log_S(t1 + eps, t2) - log_S(t1, t2)) / eps
  h2 <- -(log_S(t1, t2 + eps) - log_S(t1, t2)) / eps
  c(h1 = h1, h2 = h2)
}

# ------------------------------------------------------------------------------
# Bivariate mean residual life
# ------------------------------------------------------------------------------

#' Bivariate Mean Residual Life Function
#'
#' @description
#' Computes the bivariate mean residual life (MRL) function
#' \deqn{m_1(t_1,t_2) = E(X_{t_1|t_2}) = \frac{\int_{t_1}^{\infty}
#'   \bar{F}(x_1,t_2)\,dx_1}{\bar{F}(t_1,t_2)}}
#' and analogously \eqn{m_2(t_1,t_2)}.
#'
#' @param t1,t2 Non-negative thresholds.
#' @param surv_fn Joint survival function; defaults to Gumbel bivariate
#'   exponential.
#' @param k1,k2,theta Gumbel parameters (used when \code{surv_fn = NULL}).
#' @param upper Upper integration bound (default \code{100}).
#'
#' @return A named numeric vector \code{(m1, m2)}.
#'
#' @examples
#' biv_mean_residual(t1 = 0.5, t2 = 0.5)
#' biv_mean_residual(t1 = 1, t2 = 0.5, k1 = 1, k2 = 2, theta = 0.2)
#'
#' @references
#' Jayalekshmi S., Rajesh G., Nair N.U. (2022).
#' \doi{10.1080/03610926.2022.2085874}
#'
#' @export
biv_mean_residual <- function(t1, t2,
                               surv_fn = NULL,
                               k1 = 1, k2 = 1, theta = 0,
                               upper = 100) {
  .check_nonneg(t1, "t1"); .check_nonneg(t2, "t2")
  if (is.null(surv_fn))
    surv_fn <- function(x1, x2) sgumbel_biv(x1, x2, k1, k2, theta)

  Ft1t2 <- surv_fn(t1, t2)
  if (Ft1t2 <= 0) stop("surv_fn(t1, t2) = 0; support exceeded.")

  m1 <- .integrate1d(function(x1) surv_fn(x1, t2), t1, upper) / Ft1t2
  m2 <- .integrate1d(function(x2) surv_fn(t1, x2), t2, upper) / Ft1t2
  c(m1 = m1, m2 = m2)
}

# ------------------------------------------------------------------------------
# NBUHR / NWUHR aging class
# ------------------------------------------------------------------------------

#' Test NBUHR / NWUHR Aging Class
#'
#' @description
#' Checks whether a bivariate lifetime distribution belongs to the NBUHR
#' (New Better than Used in Hazard Rate) or NWUHR (New Worse than Used) aging
#' class.  A distribution is NBUHR if
#' \deqn{h_1(0,t_2) \ge h_1(t_1,t_2)\;\text{ for all }t_1 > 0}
#' and similarly for the second component.  The function evaluates this at a
#' grid of \eqn{t_1} values.
#'
#' @param t2 Fixed value of the second age coordinate.
#' @param t1_grid Numeric vector of \eqn{t_1} values to check (default 0.1 to
#'   5 in steps of 0.1).
#' @param surv_fn Joint survival function; defaults to Gumbel bivariate
#'   exponential.
#' @param k1,k2,theta Gumbel parameters.
#'
#' @return A list with components:
#'   \describe{
#'     \item{\code{class1}}{Character: \code{"NBUHR"}, \code{"NWUHR"}, or
#'       \code{"neither"} for the first component.}
#'     \item{\code{class2}}{Same for the second component.}
#'     \item{\code{h1_grid}}{Numeric vector of \eqn{h_1(t_1,t_2)} values.}
#'     \item{\code{h2_grid}}{Numeric vector of \eqn{h_2(t_1,t_2)} values.}
#'   }
#'
#' @examples
#' nbuhr_test(t2 = 1, k1 = 1, k2 = 1, theta = 0.3)
#' nbuhr_test(t2 = 0.5,
#'            surv_fn = function(x1, x2) exp(-(x1 + x2)))
#'
#' @references
#' Jayalekshmi S., Rajesh G., Nair N.U. (2022), Definition 3.2.
#' \doi{10.1080/03610926.2022.2085874}
#'
#' @export
nbuhr_test <- function(t2 = 1,
                        t1_grid = seq(0.1, 5, by = 0.1),
                        surv_fn = NULL,
                        k1 = 1, k2 = 1, theta = 0) {
  .check_nonneg(t2, "t2")
  if (is.null(surv_fn))
    surv_fn <- function(x1, x2) sgumbel_biv(x1, x2, k1, k2, theta)

  h0 <- biv_hazard_gradient(0, t2, surv_fn = surv_fn)
  h_grid <- t(sapply(t1_grid, function(t1)
    biv_hazard_gradient(t1, t2, surv_fn = surv_fn)))
  h1_vals <- h_grid[, 1]; h2_vals <- h_grid[, 2]

  classify <- function(h0_i, h_vals) {
    if (all(h0_i >= h_vals)) "NBUHR"
    else if (all(h0_i <= h_vals)) "NWUHR"
    else "neither"
  }

  list(
    class1  = classify(h0["h1"], h1_vals),
    class2  = classify(h0["h2"], h2_vals),
    h1_grid = h1_vals,
    h2_grid = h2_vals,
    t1_grid = t1_grid
  )
}

# ------------------------------------------------------------------------------
# Nonparametric estimator
# ------------------------------------------------------------------------------

#' Nonparametric Estimator for the Bivariate Laplace Transform of Residual Lives
#'
#' @description
#' Given a bivariate sample \eqn{(X_{1i}, X_{2i}),\; i=1,\ldots,n}, estimates
#' \deqn{\hat{L}^*_{1}(s_1; t_1, t_2)
#'   = \frac{\sum_{i:X_{1i}>t_1,\,X_{2i}>t_2}
#'     \int_{t_1}^{X_{1i}} e^{-s_1 u}\,du}{e^{-s_1 t_1} \cdot
#'     \#\{X_{1i}>t_1,X_{2i}>t_2\}}}
#' and analogously for the second component, using the empirical survival
#' function as described in Jayalekshmi et al. (2022), Section 6.
#'
#' @param data A two-column numeric matrix or data frame with columns for
#'   \eqn{X_1} and \eqn{X_2}.
#' @param s1,s2 Positive Laplace parameters.
#' @param t1,t2 Non-negative truncation ages.
#'
#' @return A named numeric vector \code{(L1_hat, L2_hat)}.
#'
#' @examples
#' set.seed(123)
#' dat <- rgumbel_biv(200, k1 = 1, k2 = 1, theta = 0.5)
#' np_blt_residual(dat, s1 = 1, s2 = 1, t1 = 0.3, t2 = 0.3)
#'
#' # Compare with closed form
#' blt_residual_gumbel(s1 = 1, s2 = 1, t1 = 0.3, t2 = 0.3, theta = 0.5)
#'
#' @references
#' Jayalekshmi S., Rajesh G., Nair N.U. (2022), Section 6.
#' \doi{10.1080/03610926.2022.2085874}
#'
#' @seealso \code{\link{blt_residual_gumbel}}, \code{\link{sim_blt_residual}}
#' @export
np_blt_residual <- function(data, s1, s2, t1 = 0, t2 = 0) {
  if (!is.matrix(data)) data <- as.matrix(data)
  if (ncol(data) < 2L) stop("`data` must have at least 2 columns.")
  .check_positive(s1, "s1"); .check_positive(s2, "s2")
  .check_nonneg(t1, "t1");   .check_nonneg(t2, "t2")

  x1 <- data[, 1]; x2 <- data[, 2]

  idx <- which(x1 > t1 & x2 > t2)
  m   <- length(idx)
  if (m == 0L) {
    warning("No observations exceed (t1, t2); returning NA.")
    return(c(L1_hat = NA_real_, L2_hat = NA_real_))
  }

  # L1*: integral from t1 to x1i of e^{-s1 u} du for each i in idx
  int_vals1 <- (exp(-s1 * t1) - exp(-s1 * x1[idx])) / s1
  L1_hat <- sum(int_vals1) / (exp(-s1 * t1) * m)

  int_vals2 <- (exp(-s2 * t2) - exp(-s2 * x2[idx])) / s2
  L2_hat <- sum(int_vals2) / (exp(-s2 * t2) * m)

  c(L1_hat = L1_hat, L2_hat = L2_hat)
}

# ------------------------------------------------------------------------------
# Simulation study for the estimator
# ------------------------------------------------------------------------------

#' Monte-Carlo Simulation Study for the BLT Residual Estimator
#'
#' @description
#' Evaluates the performance of \code{\link{np_blt_residual}} via repeated
#' simulation from the Gumbel bivariate exponential distribution and compares
#' estimates to the closed-form \code{\link{blt_residual_gumbel}} values.
#' Returns bias, variance, and mean squared error (MSE).
#'
#' @param n_obs Sample size per replicate.
#' @param n_sim Number of simulation replicates.
#' @param s1,s2 Laplace parameters.
#' @param t1,t2 Truncation ages.
#' @param k1,k2,theta Gumbel parameters.
#' @param seed Random seed for reproducibility.
#'
#' @return A data frame with columns \code{component}, \code{true_value},
#'   \code{mean_est}, \code{bias}, \code{variance}, \code{mse}.
#'
#' @examples
#' sim_blt_residual(n_obs = 100, n_sim = 50, s1 = 1, s2 = 1,
#'                  t1 = 0.3, t2 = 0.3, k1 = 1, k2 = 1, theta = 0.5)
#'
#' @references
#' Jayalekshmi S., Rajesh G., Nair N.U. (2022), Section 6.
#' \doi{10.1080/03610926.2022.2085874}
#'
#' @seealso \code{\link{np_blt_residual}}
#' @export
sim_blt_residual <- function(n_obs = 200, n_sim = 100,
                              s1 = 1, s2 = 1,
                              t1 = 0.3, t2 = 0.3,
                              k1 = 1, k2 = 1, theta = 0.5,
                              seed = 42L) {
  set.seed(seed)
  true_vals <- blt_residual_gumbel(s1, s2, t1, t2, k1, k2, theta)

  ests <- replicate(n_sim, {
    dat <- rgumbel_biv(n_obs, k1, k2, theta)
    np_blt_residual(dat, s1, s2, t1, t2)
  })

  summarise_comp <- function(true, est_vec, label) {
    bias <- mean(est_vec, na.rm = TRUE) - true
    vr   <- stats::var(est_vec, na.rm = TRUE)
    data.frame(
      component   = label,
      true_value  = true,
      mean_est    = mean(est_vec, na.rm = TRUE),
      bias        = bias,
      variance    = vr,
      mse         = bias^2 + vr,
      stringsAsFactors = FALSE
    )
  }

  rbind(
    summarise_comp(true_vals[1], ests[1, ], "L1_star"),
    summarise_comp(true_vals[2], ests[2, ], "L2_star")
  )
}
