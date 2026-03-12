# ==============================================================================
# Bivariate Laplace Transform of Reversed (Past) Residual Lives
# Reference: Jayalekshmi, Rajesh — IJRQSE
# ==============================================================================

# ------------------------------------------------------------------------------
# Core transform
# ------------------------------------------------------------------------------

#' Bivariate Laplace Transform of Reversed Residual Lives
#'
#' @description
#' Computes the bivariate Laplace transform of reversed (past) residual lives.
#' For a random pair \eqn{(X_1,X_2)} with joint distribution function
#' \eqn{F(x_1,x_2)}, the transform is
#' \deqn{L_{t_1|t_2}(s_1) = e^{-s_1 t_1} +
#'   \frac{s_1 \int_0^{t_1} e^{-s_1 x_1} F(x_1, t_2)\,dx_1}{F(t_1, t_2)}}
#' and the associated \eqn{G} function (useful for ordering) is
#' \deqn{G_1(t_1,t_2) =
#'   \frac{\int_0^{t_1} e^{-s_1 x_1} F(x_1, t_2)\,dx_1}{
#'     e^{-s_1 t_1} F(t_1,t_2)}.}
#'
#' @param s1,s2 Positive Laplace parameters.
#' @param t1,t2 Positive truncation times (\eqn{t_i > 0}).
#' @param cdf_fn A function \code{function(x1, x2)} returning the joint CDF
#'   \eqn{F(x_1,x_2)}.  Defaults to the FGM distribution.
#' @param theta FGM association parameter (used when \code{cdf_fn = NULL}).
#' @param g_form Logical; if \code{TRUE} returns the \eqn{G} form instead of
#'   \eqn{L}.
#'
#' @return A named numeric vector \code{(L1, L2)} or \code{(G1, G2)}.
#'
#' @examples
#' # FGM distribution (default)
#' blt_reversed(s1 = 1, s2 = 1, t1 = 0.6, t2 = 0.6)
#'
#' # G form
#' blt_reversed(s1 = 1, s2 = 1, t1 = 0.6, t2 = 0.6, g_form = TRUE)
#'
#' # User-supplied CDF
#' cdf <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.5)
#' blt_reversed(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5, cdf_fn = cdf)
#'
#' @references
#' Jayalekshmi S., Rajesh G. Bivariate Laplace transform order and ordering of
#' reversed residual lives. *International Journal of Reliability, Quality and
#' Safety Engineering*.
#'
#' @seealso \code{\link{blt_reversed_fgm}}, \code{\link{blt_order_reversed}}
#' @export
blt_reversed <- function(s1, s2, t1, t2,
                          cdf_fn = NULL, theta = 0,
                          g_form = FALSE) {
  .check_positive(s1, "s1"); .check_positive(s2, "s2")
  .check_positive(t1, "t1"); .check_positive(t2, "t2")

  if (is.null(cdf_fn))
    cdf_fn <- function(x1, x2) pfgm_biv(x1, x2, theta)

  Ft1t2 <- cdf_fn(t1, t2)
  if (Ft1t2 <= 0) stop("cdf_fn(t1, t2) = 0; no mass at (t1, t2).")

  int1 <- .integrate1d(function(x1) exp(-s1 * x1) * cdf_fn(x1, t2), 0, t1)
  int2 <- .integrate1d(function(x2) exp(-s2 * x2) * cdf_fn(t1, x2), 0, t2)

  if (g_form) {
    G1 <- int1 / (exp(-s1 * t1) * Ft1t2)
    G2 <- int2 / (exp(-s2 * t2) * Ft1t2)
    return(c(G1 = G1, G2 = G2))
  }

  L1 <- exp(-s1 * t1) + s1 * int1 / Ft1t2
  L2 <- exp(-s2 * t2) + s2 * int2 / Ft1t2
  c(L1 = L1, L2 = L2)
}

# ------------------------------------------------------------------------------
# Closed-form: FGM distribution
# ------------------------------------------------------------------------------

#' Closed-Form BLT of Reversed Residual Lives for the FGM Distribution
#'
#' @description
#' Computes the bivariate Laplace transform of the FGM distribution in closed
#' form (Jayalekshmi and Rajesh, Example 1):
#' \deqn{L_X(s_1,s_2) = \frac{(1-e^{-s_1})(1-e^{-s_2})}{s_1 s_2}
#'   + \theta \Phi(s_1,s_2)}
#' where \eqn{\Phi} captures the dependence correction.
#'
#' @param s1,s2 Positive Laplace parameters.
#' @param theta FGM association parameter, \eqn{|\theta| \le 1}.
#'
#' @return Scalar numeric; the joint bivariate Laplace transform.
#'
#' @examples
#' blt_reversed_fgm(s1 = 1, s2 = 1, theta = 0.5)
#' blt_reversed_fgm(s1 = 2, s2 = 0.5, theta = -0.3)
#'
#' @references
#' Jayalekshmi S., Rajesh G. Bivariate Laplace transform order and ordering of
#' reversed residual lives. *International Journal of Reliability, Quality and
#' Safety Engineering*, Example 1.
#'
#' @export
blt_reversed_fgm <- function(s1, s2, theta = 0) {
  .check_positive(s1, "s1"); .check_positive(s2, "s2")
  .check_range(theta, -1, 1, "theta")

  phi0_s1 <- (1 - exp(-s1)) / s1
  phi0_s2 <- (1 - exp(-s2)) / s2

  # Phi correction: integral of theta*(1-2x1)*(1-2x2)*e^{-s1 x1 - s2 x2} dx1 dx2
  phi_s1 <- (1 - exp(-s1) - s1 * exp(-s1)) / s1^2   # int_0^1 (1-2u)e^{-su} du
  phi_s2 <- (1 - exp(-s2) - s2 * exp(-s2)) / s2^2

  phi0_s1 * phi0_s2 + theta * phi_s1 * phi_s2
}

# ------------------------------------------------------------------------------
# Closed-form: Bivariate power distribution
# ------------------------------------------------------------------------------

#' Bivariate Laplace Transform of Reversed Residual Lives — Power Distribution
#'
#' @description
#' Computes the \eqn{G_1} function for the bivariate power distribution:
#' \deqn{G_1(t_1,t_2) =
#'   \frac{\int_0^{t_1} e^{-s_1 x_1}
#'     x_1^{p_1+\theta\log t_2}\,dx_1}{e^{-s_1 t_1}\, t_1^{p_1+\theta\log t_2}}}
#' evaluated numerically.
#'
#' @param s1 Positive Laplace parameter.
#' @param t1,t2 Positive truncation times.
#' @param p1,p2 Positive shape parameters.
#' @param theta Association parameter, \eqn{0 \le \theta \le 1}.
#'
#' @return Named numeric vector \code{(G1, reversed_hazard_h1)}.
#'
#' @examples
#' blt_reversed_power(s1 = 1, t1 = 0.5, t2 = 0.5, p1 = 2, p2 = 2, theta = 0.3)
#'
#' @references
#' Jayalekshmi S., Rajesh G. — IJRQSE, Example 2.
#'
#' @export
blt_reversed_power <- function(s1, t1, t2, p1 = 1, p2 = 1, theta = 0) {
  .check_positive(s1, "s1")
  .check_positive(t1, "t1"); .check_positive(t2, "t2")
  .check_positive(p1, "p1"); .check_positive(p2, "p2")
  .check_range(theta, 0, 1, "theta")

  alpha <- p1 + theta * log(pmax(t2, .Machine$double.eps))
  Ft1t2 <- t1^alpha * t2^p2

  int1 <- .integrate1d(
    function(x1) exp(-s1 * x1) * x1^(p1 + theta * log(pmax(t2, .Machine$double.eps))),
    0, t1
  )
  G1 <- int1 / (exp(-s1 * t1) * Ft1t2)
  # Reversed hazard: h1(t1,t2) = s1 + 1/G1 - d/dt1 log G1
  # Approximate numerically
  eps <- 1e-6
  int1_p <- .integrate1d(
    function(x1) exp(-s1 * x1) *
      x1^(p1 + theta * log(pmax(t2, .Machine$double.eps))),
    0, t1 + eps
  )
  Ft1p <- (t1 + eps)^alpha * t2^p2
  G1p <- int1_p / (exp(-s1 * (t1 + eps)) * Ft1p)
  dlogG1dt1 <- (log(pmax(G1p, .Machine$double.eps)) -
                  log(pmax(G1, .Machine$double.eps))) / eps
  h1 <- s1 + 1 / pmax(G1, .Machine$double.eps) - dlogG1dt1

  c(G1 = G1, reversed_hazard_h1 = h1)
}

# ------------------------------------------------------------------------------
# Bivariate reversed hazard gradient
# ------------------------------------------------------------------------------

#' Bivariate Reversed Hazard Gradient
#'
#' @description
#' Computes the bivariate reversed hazard gradient
#' \deqn{h_i(x_1,x_2) = \frac{\partial}{\partial x_i}\log F(x_1,x_2),
#'   \quad i = 1, 2.}
#'
#' @param x1,x2 Positive evaluation points.
#' @param cdf_fn Joint CDF function; defaults to FGM with parameter
#'   \code{theta}.
#' @param theta FGM parameter (used when \code{cdf_fn = NULL}).
#' @param eps Numerical differentiation step.
#'
#' @return Named numeric vector \code{(rh1, rh2)}.
#'
#' @examples
#' biv_rhazard_gradient(x1 = 0.5, x2 = 0.5, theta = 0.3)
#'
#' @references
#' Jayalekshmi S., Rajesh G. — IJRQSE, Section 2.
#'
#' @export
biv_rhazard_gradient <- function(x1, x2, cdf_fn = NULL, theta = 0,
                                  eps = 1e-7) {
  .check_positive(x1, "x1"); .check_positive(x2, "x2")
  if (is.null(cdf_fn))
    cdf_fn <- function(u1, u2) pfgm_biv(u1, u2, theta)

  logF <- function(u1, u2) .safe_log(cdf_fn(u1, u2))
  rh1 <- (logF(x1 + eps, x2) - logF(x1, x2)) / eps
  rh2 <- (logF(x1, x2 + eps) - logF(x1, x2)) / eps
  c(rh1 = rh1, rh2 = rh2)
}

# ------------------------------------------------------------------------------
# Bivariate reversed mean residual life
# ------------------------------------------------------------------------------

#' Bivariate Reversed Mean Residual Life Function
#'
#' @description
#' Computes the bivariate reversed mean residual life (RMRL):
#' \deqn{m_1(x_1,x_2) = \frac{\int_0^{x_1} F(t_1,x_2)\,dt_1}{F(x_1,x_2)},
#'   \quad m_2(x_1,x_2) = \frac{\int_0^{x_2} F(x_1,t_2)\,dt_2}{F(x_1,x_2)}.}
#'
#' @param x1,x2 Positive evaluation points.
#' @param cdf_fn Joint CDF; defaults to FGM.
#' @param theta FGM parameter.
#'
#' @return Named numeric vector \code{(m1, m2)}.
#'
#' @examples
#' biv_rmrl(x1 = 0.5, x2 = 0.5, theta = 0.3)
#' biv_rmrl(x1 = 0.7, x2 = 0.4, theta = -0.2)
#'
#' @references
#' Jayalekshmi S., Rajesh G. — IJRQSE, Section 2.
#'
#' @export
biv_rmrl <- function(x1, x2, cdf_fn = NULL, theta = 0) {
  .check_positive(x1, "x1"); .check_positive(x2, "x2")
  if (is.null(cdf_fn))
    cdf_fn <- function(u1, u2) pfgm_biv(u1, u2, theta)

  Fx1x2 <- cdf_fn(x1, x2)
  if (Fx1x2 <= 0) stop("cdf_fn(x1, x2) = 0.")

  m1 <- .integrate1d(function(t1) cdf_fn(t1, x2), 0, x1) / Fx1x2
  m2 <- .integrate1d(function(t2) cdf_fn(x1, t2), 0, x2) / Fx1x2
  c(m1 = m1, m2 = m2)
}
