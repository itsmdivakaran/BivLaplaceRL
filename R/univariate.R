# ==============================================================================
# Univariate Laplace Transform of Residual Life and Related Functions
# ==============================================================================

#' Univariate Laplace Transform of Residual Life
#'
#' @description
#' Computes the Laplace transform of the residual life of a non-negative
#' continuous random variable conditioned on survival past time \eqn{t}:
#' \deqn{L_X(s,t) = E[e^{-sX} \mid X > t]
#'   = \frac{1}{\bar{F}(t)}\int_t^\infty e^{-sx} f(x)\,dx,
#'   \quad s \geq 0,\; t \geq 0.}
#'
#' At \eqn{t = 0} this reduces to the standard Laplace transform
#' \eqn{L_X(s) = E[e^{-sX}]}.
#'
#' @param dens_fn Density function \eqn{f(x)}.
#' @param surv_fn Survival function \eqn{\bar{F}(x)}; computed by numerical
#'   integration of \code{dens_fn} if \code{NULL}.
#' @param s Non-negative Laplace parameter.
#' @param t Truncation time (default 0).
#' @param upper Upper integration limit.
#'
#' @return Scalar numeric.
#'
#' @examples
#' # Exp(1): L_X(s, 0) = 1/(1+s) = 0.5 at s=1
#' f  <- function(x) dexp(x, 1)
#' Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
#' lt_residual(f, Fb, s = 1, t = 0)
#'
#' # Memoryless property: L_X(s,t) should equal L_X(s,0) for Exp
#' lt_residual(f, Fb, s = 1, t = 0.5)
#'
#' @references
#' Belzunce F., Ortega E., Ruiz J.M. (1999). The Laplace order and ordering of
#' residual lives. *Statistics & Probability Letters*, 42(2), 145--156.
#'
#' @seealso \code{\link{hazard_rate}}, \code{\link{mean_residual}},
#'   \code{\link{np_lt_residual}}, \code{\link{lt_rl_order}},
#'   \code{\link{blt_residual}}
#' @export
lt_residual <- function(dens_fn, surv_fn = NULL, s, t = 0, upper = 100) {
  .check_nonneg(s, "s")
  .check_nonneg(t, "t")
  if (is.null(surv_fn)) {
    surv_fn <- function(x) .integrate1d(dens_fn, x, upper)
  }
  St <- surv_fn(t)
  if (St <= 0) {
    warning("surv_fn(t) = 0; returning NA.")
    return(NA_real_)
  }
  integrand <- function(x) exp(-s * x) * dens_fn(x)
  .integrate1d(integrand, t, upper) / St
}

# ------------------------------------------------------------------------------
# Hazard rate
# ------------------------------------------------------------------------------

#' Univariate Hazard Rate Function
#'
#' @description
#' Computes the hazard rate (failure rate) of a non-negative continuous random
#' variable:
#' \deqn{h(t) = \frac{f(t)}{\bar{F}(t)}, \quad t \geq 0.}
#'
#' @param dens_fn Density function \eqn{f(t)}.
#' @param surv_fn Survival function \eqn{\bar{F}(t)}; computed by numerical
#'   integration if \code{NULL}.
#' @param t Scalar or numeric vector of time points.
#' @param upper Upper integration limit (used only when \code{surv_fn = NULL}).
#'
#' @return Numeric vector of hazard rates at \code{t}.
#'
#' @examples
#' # Exp(1): constant hazard rate = 1
#' f  <- function(x) dexp(x, 1)
#' Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
#' hazard_rate(f, Fb, t = c(0.5, 1, 2))
#'
#' # Gamma(2,1): increasing hazard rate
#' fG  <- function(x) dgamma(x, shape = 2, rate = 1)
#' FbG <- function(x) pgamma(x, shape = 2, rate = 1, lower.tail = FALSE)
#' hazard_rate(fG, FbG, t = c(0.5, 1, 2))
#'
#' @seealso \code{\link{mean_residual}}, \code{\link{hr_order}}
#' @export
hazard_rate <- function(dens_fn, surv_fn = NULL, t, upper = 100) {
  if (is.null(surv_fn)) {
    surv_fn <- function(x) .integrate1d(dens_fn, x, upper)
  }
  sapply(t, function(ti) {
    St <- surv_fn(ti)
    if (St <= 0) NA_real_ else dens_fn(ti) / St
  })
}

# ------------------------------------------------------------------------------
# Mean residual life
# ------------------------------------------------------------------------------

#' Univariate Mean Residual Life
#'
#' @description
#' Computes the mean residual life (mean excess function):
#' \deqn{m(t) = E[X - t \mid X > t]
#'   = \frac{1}{\bar{F}(t)}\int_t^\infty \bar{F}(x)\,dx, \quad t \geq 0.}
#'
#' @param surv_fn Survival function \eqn{\bar{F}(x)}.
#' @param t Scalar or numeric vector of time points.
#' @param upper Upper integration limit.
#'
#' @return Numeric vector of MRL values at \code{t}.
#'
#' @examples
#' # Exp(1): constant MRL = 1 (memoryless)
#' Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
#' mean_residual(Fb, t = c(0, 0.5, 1, 2))
#'
#' # Gamma(2,1): decreasing MRL
#' FbG <- function(x) pgamma(x, shape = 2, rate = 1, lower.tail = FALSE)
#' mean_residual(FbG, t = c(0, 0.5, 1, 2))
#'
#' @seealso \code{\link{hazard_rate}}, \code{\link{mrl_order}}
#' @export
mean_residual <- function(surv_fn, t = 0, upper = 100) {
  sapply(t, function(ti) {
    St <- surv_fn(ti)
    if (St <= 0) NA_real_
    else .integrate1d(surv_fn, ti, upper) / St
  })
}

# ------------------------------------------------------------------------------
# LT-rl order (univariate)
# ------------------------------------------------------------------------------

#' Univariate Laplace Transform Order of Residual Lives
#'
#' @description
#' Checks whether \eqn{X \leq_{\rm Lt\text{-}rl} Y}: the Laplace transform of
#' the residual life of \eqn{X} is dominated by that of \eqn{Y} pointwise
#' over a grid of \eqn{(s, t)} values:
#' \deqn{L_X(s,t) \leq L_Y(s,t) \quad \forall\, s \geq 0,\; t \geq 0.}
#'
#' The order is verified numerically on \code{s_grid} x \code{t_grid}.
#'
#' @param dens_fn_X,dens_fn_Y Density functions of \eqn{X} and \eqn{Y}.
#' @param surv_fn_X,surv_fn_Y Survival functions; computed if \code{NULL}.
#' @param s_grid Numeric vector of Laplace parameter values to check.
#' @param t_grid Numeric vector of truncation times to check.
#' @param upper Integration upper bound.
#'
#' @return A list with:
#' \describe{
#'   \item{\code{order_holds}}{Logical; \code{TRUE} if the order holds at all
#'     grid points.}
#'   \item{\code{max_violation}}{Maximum violation \eqn{\max(L_X - L_Y, 0)}.}
#'   \item{\code{ratio_matrix}}{Matrix of \eqn{L_X(s,t)/L_Y(s,t)} values
#'     (rows = \code{s_grid}, columns = \code{t_grid}).}
#' }
#'
#' @examples
#' # Exp(1) <=_Lt-rl Exp(2): L_{Exp(lambda)}(s,t) = lambda*exp(-s*t)/(s+lambda)
#' # For s>0: 1/(s+1) < 2/(s+2), so Exp(1) has smaller LT of residual life
#' fX  <- function(x) dexp(x, 1)
#' FbX <- function(x) pexp(x, 1, lower.tail = FALSE)
#' fY  <- function(x) dexp(x, 2)
#' FbY <- function(x) pexp(x, 2, lower.tail = FALSE)
#' lt_rl_order(fX, FbX, fY, FbY,
#'             s_grid = c(0.5, 1, 2), t_grid = c(0, 0.5, 1))$order_holds
#'
#' @seealso \code{\link{lt_residual}}, \code{\link{hr_order}},
#'   \code{\link{mrl_order}}, \code{\link{blt_order_residual}}
#' @export
lt_rl_order <- function(dens_fn_X, surv_fn_X = NULL,
                         dens_fn_Y, surv_fn_Y = NULL,
                         s_grid = seq(0.5, 3, by = 0.5),
                         t_grid = seq(0, 2, by = 0.5),
                         upper = 100) {
  eval_lt <- function(fn_d, fn_s, s, t)
    lt_residual(fn_d, fn_s, s = s, t = t, upper = upper)

  ratio_mat <- outer(s_grid, t_grid, FUN = Vectorize(function(s, t) {
    lx <- eval_lt(dens_fn_X, surv_fn_X, s, t)
    ly <- eval_lt(dens_fn_Y, surv_fn_Y, s, t)
    if (is.na(lx) || is.na(ly) || ly <= 0) NA_real_ else lx / ly
  }))
  dimnames(ratio_mat) <- list(s = round(s_grid, 4), t = round(t_grid, 4))

  diff_vals <- outer(s_grid, t_grid, FUN = Vectorize(function(s, t) {
    lx <- eval_lt(dens_fn_X, surv_fn_X, s, t)
    ly <- eval_lt(dens_fn_Y, surv_fn_Y, s, t)
    if (is.na(lx) || is.na(ly)) NA_real_ else lx - ly
  }))
  valid <- diff_vals[!is.na(diff_vals)]

  list(
    order_holds   = all(valid <= 1e-6),
    max_violation = max(pmax(valid, 0)),
    ratio_matrix  = ratio_mat
  )
}

# ------------------------------------------------------------------------------
# Hazard rate order
# ------------------------------------------------------------------------------

#' Hazard Rate Order
#'
#' @description
#' Checks whether \eqn{X \leq_{\rm hr} Y} (hazard rate order): the hazard
#' rate of \eqn{X} is pointwise no greater than that of \eqn{Y}:
#' \deqn{h_X(t) \leq h_Y(t) \quad \forall\, t \geq 0.}
#'
#' Under this order \eqn{X} is stochastically longer-lived than \eqn{Y}.
#' For exponential distributions, \eqn{\mathrm{Exp}(\lambda_1)
#' \leq_{\rm hr} \mathrm{Exp}(\lambda_2)} iff \eqn{\lambda_1 \leq \lambda_2}.
#'
#' @param dens_fn_X,dens_fn_Y Density functions of \eqn{X} and \eqn{Y}.
#' @param surv_fn_X,surv_fn_Y Survival functions; computed if \code{NULL}.
#' @param t_grid Grid of time points.
#' @param upper Integration upper bound.
#'
#' @return A list with:
#' \describe{
#'   \item{\code{order_holds}}{Logical.}
#'   \item{\code{max_violation}}{Maximum of \eqn{h_X(t) - h_Y(t)} over the
#'     grid.}
#'   \item{\code{hazard_X}}{Hazard rate of \eqn{X} at \code{t_grid}.}
#'   \item{\code{hazard_Y}}{Hazard rate of \eqn{Y} at \code{t_grid}.}
#' }
#'
#' @examples
#' # Exp(1) <=_hr Exp(2): h_X(t)=1 <= 2=h_Y(t)
#' fX  <- function(x) dexp(x, 1)
#' FbX <- function(x) pexp(x, 1, lower.tail = FALSE)
#' fY  <- function(x) dexp(x, 2)
#' FbY <- function(x) pexp(x, 2, lower.tail = FALSE)
#' hr_order(fX, FbX, fY, FbY, t_grid = c(0.5, 1, 2))$order_holds
#'
#' @seealso \code{\link{hazard_rate}}, \code{\link{mrl_order}},
#'   \code{\link{lt_rl_order}}
#' @export
hr_order <- function(dens_fn_X, surv_fn_X = NULL,
                      dens_fn_Y, surv_fn_Y = NULL,
                      t_grid = seq(0.1, 3, by = 0.5),
                      upper = 100) {
  hX <- hazard_rate(dens_fn_X, surv_fn_X, t = t_grid, upper = upper)
  hY <- hazard_rate(dens_fn_Y, surv_fn_Y, t = t_grid, upper = upper)
  diff <- hX - hY
  valid <- diff[!is.na(diff)]
  list(
    order_holds   = all(valid <= 1e-6),
    max_violation = max(pmax(valid, 0)),
    hazard_X      = hX,
    hazard_Y      = hY
  )
}

# ------------------------------------------------------------------------------
# MRL order
# ------------------------------------------------------------------------------

#' Mean Residual Life Order
#'
#' @description
#' Checks whether \eqn{X \leq_{\rm mrl} Y} (mean residual life order): the MRL
#' of \eqn{X} is pointwise no greater than that of \eqn{Y}:
#' \deqn{m_X(t) \leq m_Y(t) \quad \forall\, t \geq 0.}
#'
#' @param surv_fn_X,surv_fn_Y Survival functions of \eqn{X} and \eqn{Y}.
#' @param t_grid Grid of time points.
#' @param upper Integration upper bound.
#'
#' @return A list with:
#' \describe{
#'   \item{\code{order_holds}}{Logical.}
#'   \item{\code{max_violation}}{Maximum of \eqn{m_X(t) - m_Y(t)} over the
#'     grid.}
#'   \item{\code{mrl_X}}{MRL of \eqn{X} at \code{t_grid}.}
#'   \item{\code{mrl_Y}}{MRL of \eqn{Y} at \code{t_grid}.}
#' }
#'
#' @examples
#' # Exp(2) <=_mrl Exp(1): m_X(t)=0.5 <= 1=m_Y(t)
#' FbX <- function(x) pexp(x, 2, lower.tail = FALSE)
#' FbY <- function(x) pexp(x, 1, lower.tail = FALSE)
#' mrl_order(FbX, FbY, t_grid = c(0, 0.5, 1, 2))$order_holds
#'
#' @seealso \code{\link{mean_residual}}, \code{\link{hr_order}},
#'   \code{\link{lt_rl_order}}
#' @export
mrl_order <- function(surv_fn_X, surv_fn_Y,
                       t_grid = seq(0, 3, by = 0.5),
                       upper = 100) {
  mX <- mean_residual(surv_fn_X, t = t_grid, upper = upper)
  mY <- mean_residual(surv_fn_Y, t = t_grid, upper = upper)
  diff <- mX - mY
  valid <- diff[!is.na(diff)]
  list(
    order_holds   = all(valid <= 1e-6),
    max_violation = max(pmax(valid, 0)),
    mrl_X         = mX,
    mrl_Y         = mY
  )
}

# ------------------------------------------------------------------------------
# Nonparametric estimator for univariate LT of residual life
# ------------------------------------------------------------------------------

#' Nonparametric Estimator for the Univariate Laplace Transform of Residual Life
#'
#' @description
#' Given a sample \eqn{X_1, \ldots, X_n}, estimates the Laplace transform of
#' the residual life using the empirical survival function:
#' \deqn{\hat{L}_X(s,t) =
#'   \frac{\displaystyle\sum_{i:\,X_i > t} e^{-s X_i}}
#'        {\#\{i : X_i > t\}}.}
#'
#' @param x Numeric vector; observed sample.
#' @param s Non-negative Laplace parameter.
#' @param t Truncation time (default 0).
#'
#' @return Scalar numeric estimate of \eqn{L_X(s,t)}.
#'
#' @examples
#' set.seed(1)
#' x <- rexp(300, rate = 1)
#'
#' # Estimate at s=1, t=0: true value 1/(1+1) = 0.5
#' np_lt_residual(x, s = 1, t = 0)
#'
#' # Estimate at s=1, t=0.5: true value still approx 0.5 (memoryless)
#' np_lt_residual(x, s = 1, t = 0.5)
#'
#' @seealso \code{\link{lt_residual}}
#' @export
np_lt_residual <- function(x, s, t = 0) {
  .check_nonneg(s, "s")
  .check_nonneg(t, "t")
  x <- x[!is.na(x)]
  xi_gt <- x[x > t]
  n_gt <- length(xi_gt)
  if (n_gt == 0L) {
    warning("No observations exceed t; returning NA.")
    return(NA_real_)
  }
  sum(exp(-s * xi_gt)) / n_gt
}
