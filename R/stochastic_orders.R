# ==============================================================================
# Stochastic Ordering Functions
# References: Jayalekshmi, Rajesh, Nair (2022); Jayalekshmi, Rajesh (IJRQSE)
# ==============================================================================

# ------------------------------------------------------------------------------
# BLt-rl order (residual lives)
# ------------------------------------------------------------------------------

#' Bivariate Laplace Transform Order of Residual Lives (BLt-rl)
#'
#' @description
#' Checks whether random vector \eqn{X} is smaller than \eqn{Y} in the
#' bivariate Laplace transform order of residual lives (BLt-rl).
#'
#' \eqn{X \le_{\rm BLt\text{-}rl} Y} if and only if for all
#' \eqn{(t_1,t_2)} in the support:
#' \deqn{\frac{\int_{t_1}^\infty e^{-s_1 x_1}\bar{F}_X(x_1,t_2)\,dx_1}{
#'   e^{-s_1 t_1}\bar{F}_X(t_1,t_2)}
#'   \ge
#'   \frac{\int_{t_1}^\infty e^{-s_1 x_1}\bar{F}_Y(x_1,t_2)\,dx_1}{
#'   e^{-s_1 t_1}\bar{F}_Y(t_1,t_2)}}
#' i.e.\ \eqn{L^*_{X_{t_1|t_2}}(s_1) \ge L^*_{Y_{t_1|t_2}}(s_1)} for all
#' \eqn{t_1,t_2,s_1}.  The function evaluates this inequality at a grid.
#'
#' @param surv_X,surv_Y Joint survival functions for \eqn{X} and \eqn{Y}
#'   respectively, each of the form \code{function(x1, x2)}.
#' @param s1,s2 Laplace parameters to evaluate at.
#' @param t1_grid,t2_grid Grids of truncation times (default 0.1 to 3).
#' @param tol Tolerance for declaring inequality (default \code{1e-6}).
#'
#' @return A list with elements:
#'   \describe{
#'     \item{\code{order_holds}}{Logical; \code{TRUE} if \eqn{X \le Y} at all
#'       grid points.}
#'     \item{\code{violations}}{Data frame of grid points where the ordering
#'       fails.}
#'     \item{\code{ratio_matrix}}{Matrix of \eqn{L^*_X / L^*_Y} values.}
#'   }
#'
#' @examples
#' # Compare two Gumbel distributions
#' sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1, theta = 0.2)
#' sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 2, k2 = 2, theta = 0.2)
#' blt_order_residual(sX, sY, s1 = 1, s2 = 1,
#'                    t1_grid = c(0.1, 0.5, 1), t2_grid = c(0.1, 0.5))
#'
#' @references
#' Jayalekshmi S., Rajesh G., Nair N.U. (2022), Definition 4.1 & Prop. 4.1.
#' \doi{10.1080/03610926.2022.2085874}
#'
#' @seealso \code{\link{blt_residual}}, \code{\link{biv_whr_order}}
#' @export
blt_order_residual <- function(surv_X, surv_Y, s1 = 1, s2 = 1,
                                t1_grid = seq(0.1, 3, by = 0.5),
                                t2_grid = seq(0.1, 3, by = 0.5),
                                tol = 1e-6) {
  .check_positive(s1, "s1"); .check_positive(s2, "s2")

  violations <- data.frame(t1 = numeric(0), t2 = numeric(0),
                            L1_star_X = numeric(0), L1_star_Y = numeric(0))
  ratio_mat <- matrix(NA_real_, nrow = length(t1_grid), ncol = length(t2_grid),
                      dimnames = list(
                        paste0("t1=", t1_grid),
                        paste0("t2=", t2_grid)
                      ))

  for (i in seq_along(t1_grid)) {
    for (j in seq_along(t2_grid)) {
      t1 <- t1_grid[i]; t2 <- t2_grid[j]

      Lx <- tryCatch(
        blt_residual(s1, s2, t1, t2, surv_fn = surv_X, star = TRUE)[1],
        error = function(e) NA_real_
      )
      Ly <- tryCatch(
        blt_residual(s1, s2, t1, t2, surv_fn = surv_Y, star = TRUE)[1],
        error = function(e) NA_real_
      )

      if (!is.na(Lx) && !is.na(Ly) && Ly > .Machine$double.eps)
        ratio_mat[i, j] <- Lx / Ly
      # X <= Y in BLt-rl iff L*_X >= L*_Y (star is reciprocal to L)
      if (!is.na(Lx) && !is.na(Ly) && (Lx < Ly - tol)) {
        violations <- rbind(violations, data.frame(
          t1 = t1, t2 = t2, L1_star_X = Lx, L1_star_Y = Ly
        ))
      }
    }
  }
  list(
    order_holds  = nrow(violations) == 0L,
    violations   = violations,
    ratio_matrix = ratio_mat
  )
}

# ------------------------------------------------------------------------------
# BLt-Rrl order (reversed residual lives)
# ------------------------------------------------------------------------------

#' Bivariate Laplace Transform Order of Reversed Residual Lives (BLt-Rrl)
#'
#' @description
#' Checks whether \eqn{X \le_{\rm BLt\text{-}Rrl} Y}: for all
#' \eqn{(t_1,t_2)}, \eqn{L^{X}_{t_1|t_2}(s_1) \ge L^{Y}_{t_1|t_2}(s_2)}.
#'
#' @param cdf_X,cdf_Y Joint CDF functions for \eqn{X} and \eqn{Y}.
#' @param s1,s2 Laplace parameters.
#' @param t1_grid,t2_grid Grids of truncation times.
#' @param tol Tolerance.
#'
#' @return Same structure as \code{\link{blt_order_residual}}.
#'
#' @examples
#' cX <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.3)
#' cY <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.5)
#' blt_order_reversed(cX, cY, s1 = 1, s2 = 1,
#'                    t1_grid = c(0.2, 0.5), t2_grid = c(0.2, 0.5))
#'
#' @references
#' Jayalekshmi S., Rajesh G. — IJRQSE, Definition 2.
#'
#' @seealso \code{\link{blt_reversed}}, \code{\link{biv_wrhr_order}}
#' @export
blt_order_reversed <- function(cdf_X, cdf_Y, s1 = 1, s2 = 1,
                                t1_grid = seq(0.2, 0.8, by = 0.2),
                                t2_grid = seq(0.2, 0.8, by = 0.2),
                                tol = 1e-6) {
  .check_positive(s1, "s1"); .check_positive(s2, "s2")

  violations <- data.frame(t1 = numeric(0), t2 = numeric(0),
                            L1_X = numeric(0), L1_Y = numeric(0))

  for (t1 in t1_grid) {
    for (t2 in t2_grid) {
      Lx <- tryCatch(
        blt_reversed(s1, s2, t1, t2, cdf_fn = cdf_X)[1],
        error = function(e) NA_real_
      )
      Ly <- tryCatch(
        blt_reversed(s1, s2, t1, t2, cdf_fn = cdf_Y)[1],
        error = function(e) NA_real_
      )
      # X <= BLt-Rrl Y iff L_X >= L_Y
      if (!is.na(Lx) && !is.na(Ly) && (Lx < Ly - tol)) {
        violations <- rbind(violations,
                            data.frame(t1 = t1, t2 = t2, L1_X = Lx, L1_Y = Ly))
      }
    }
  }
  list(
    order_holds = nrow(violations) == 0L,
    violations  = violations
  )
}

# ------------------------------------------------------------------------------
# Weak bivariate hazard rate order (whr)
# ------------------------------------------------------------------------------

#' Weak Bivariate Hazard Rate Order
#'
#' @description
#' Checks whether \eqn{X \le_{\rm whr} Y}: the ratio
#' \eqn{\bar{F}_Y(x_1,x_2) / \bar{F}_X(x_1,x_2)} is increasing in
#' \eqn{(x_1,x_2)}, i.e.\ \eqn{h_{i,X}(t_1,t_2) \ge h_{i,Y}(t_1,t_2),\; i=1,2}.
#'
#' @param surv_X,surv_Y Joint survival functions.
#' @param t1_grid,t2_grid Evaluation grids.
#' @param tol Tolerance.
#'
#' @return A list: \code{order_holds} (logical), \code{violations} (data frame).
#'
#' @examples
#' sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1, theta = 0)
#' sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 2, k2 = 2, theta = 0)
#' biv_whr_order(sX, sY)
#'
#' @references
#' Shaked M., Shanthikumar J.G. (2007). *Stochastic Orders*. Springer.
#' Jayalekshmi S., Rajesh G., Nair N.U. (2022).
#' \doi{10.1080/03610926.2022.2085874}
#'
#' @export
biv_whr_order <- function(surv_X, surv_Y,
                           t1_grid = seq(0.1, 3, by = 0.5),
                           t2_grid = seq(0.1, 3, by = 0.5),
                           tol = 1e-6) {
  violations <- data.frame(t1 = numeric(0), t2 = numeric(0),
                            h1_X = numeric(0), h1_Y = numeric(0))

  for (t1 in t1_grid) {
    for (t2 in t2_grid) {
      hX <- biv_hazard_gradient(t1, t2, surv_fn = surv_X)
      hY <- biv_hazard_gradient(t1, t2, surv_fn = surv_Y)
      # X <=_whr Y iff h_i,X >= h_i,Y
      if (hX[1] < hY[1] - tol || hX[2] < hY[2] - tol)
        violations <- rbind(violations,
                            data.frame(t1 = t1, t2 = t2,
                                       h1_X = hX[1], h1_Y = hY[1]))
    }
  }
  list(order_holds = nrow(violations) == 0L, violations = violations)
}

# ------------------------------------------------------------------------------
# Weak bivariate MRL order (wmrl)
# ------------------------------------------------------------------------------

#' Weak Bivariate Mean Residual Life Order
#'
#' @description
#' Checks whether \eqn{X \le_{\rm wmrl} Y}:
#' \eqn{m_{i,X}(t_1,t_2) \le m_{i,Y}(t_1,t_2),\; i=1,2}.
#'
#' @param surv_X,surv_Y Joint survival functions.
#' @param t1_grid,t2_grid Evaluation grids.
#' @param tol Tolerance.
#'
#' @return List with \code{order_holds} and \code{violations}.
#'
#' @examples
#' sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1.5, k2 = 1.5)
#' sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1)
#' biv_wmrl_order(sX, sY)
#'
#' @references
#' Jayalekshmi S., Rajesh G., Nair N.U. (2022).
#' \doi{10.1080/03610926.2022.2085874}
#'
#' @export
biv_wmrl_order <- function(surv_X, surv_Y,
                            t1_grid = seq(0.1, 2, by = 0.5),
                            t2_grid = seq(0.1, 2, by = 0.5),
                            tol = 1e-6) {
  violations <- data.frame(t1 = numeric(0), t2 = numeric(0),
                            m1_X = numeric(0), m1_Y = numeric(0))
  for (t1 in t1_grid) {
    for (t2 in t2_grid) {
      mX <- tryCatch(biv_mean_residual(t1, t2, surv_fn = surv_X),
                     error = function(e) c(m1 = NA, m2 = NA))
      mY <- tryCatch(biv_mean_residual(t1, t2, surv_fn = surv_Y),
                     error = function(e) c(m1 = NA, m2 = NA))
      if (!any(is.na(c(mX, mY))) &&
          (mX[1] > mY[1] + tol || mX[2] > mY[2] + tol))
        violations <- rbind(violations,
                            data.frame(t1 = t1, t2 = t2,
                                       m1_X = mX[1], m1_Y = mY[1]))
    }
  }
  list(order_holds = nrow(violations) == 0L, violations = violations)
}

# ------------------------------------------------------------------------------
# Bivariate relative MRL order (brlmr)
# ------------------------------------------------------------------------------

#' Bivariate Relative Mean Residual Life Order
#'
#' @description
#' Checks whether \eqn{X \le_{\rm brlmr} Y}: the ratio
#' \eqn{m_{i,Y}(t_1,t_2) / m_{i,X}(t_1,t_2)} is increasing in \eqn{t_i}.
#'
#' @param surv_X,surv_Y Joint survival functions.
#' @param t2_fixed Fixed value of \eqn{t_2} for the univariate slices.
#' @param t1_grid Grid of \eqn{t_1} values.
#' @param tol Tolerance.
#'
#' @return List with \code{order_holds} and \code{ratio_values}.
#'
#' @examples
#' sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 2, k2 = 1)
#' sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1)
#' biv_brlmr_order(sX, sY, t2_fixed = 0.5)
#'
#' @references
#' Kayid M., Izadkhah S., Alshami S. (2016). Residual probability function,
#' associated orderings, and related aging classes. *Statistics and Probability
#' Letters*, 116, 37--47.
#'
#' @export
biv_brlmr_order <- function(surv_X, surv_Y, t2_fixed = 0.5,
                              t1_grid = seq(0.2, 3, by = 0.3), tol = 1e-6) {
  .check_nonneg(t2_fixed, "t2_fixed")
  ratios <- numeric(length(t1_grid))
  for (i in seq_along(t1_grid)) {
    t1 <- t1_grid[i]
    mX <- tryCatch(biv_mean_residual(t1, t2_fixed, surv_fn = surv_X)[1],
                   error = function(e) NA_real_)
    mY <- tryCatch(biv_mean_residual(t1, t2_fixed, surv_fn = surv_Y)[1],
                   error = function(e) NA_real_)
    ratios[i] <- if (is.na(mX) || mX <= 0) NA_real_ else mY / mX
  }
  increasing <- all(diff(ratios[!is.na(ratios)]) >= -tol)
  list(order_holds = increasing, ratio_values = ratios, t1_grid = t1_grid)
}

# ------------------------------------------------------------------------------
# Weak bivariate reversed hazard rate order (wrhr)
# ------------------------------------------------------------------------------

#' Weak Bivariate Reversed Hazard Rate Order
#'
#' @description
#' Checks \eqn{X \le_{\rm wrhr} Y}: the ratio
#' \eqn{F_X(x_1,x_2)/F_Y(x_1,x_2)} is decreasing in \eqn{(x_1,x_2)}, i.e.\
#' \eqn{h_{i,X}(x_1,x_2) \le h_{i,Y}(x_1,x_2),\; i=1,2}.
#'
#' @param cdf_X,cdf_Y Joint CDFs.
#' @param x1_grid,x2_grid Evaluation grids (positive values).
#' @param tol Tolerance.
#'
#' @return List with \code{order_holds} and \code{violations}.
#'
#' @examples
#' cX <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.2)
#' cY <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.5)
#' biv_wrhr_order(cX, cY)
#'
#' @references
#' Jayalekshmi S., Rajesh G. — IJRQSE, Section 2.
#'
#' @export
biv_wrhr_order <- function(cdf_X, cdf_Y,
                            x1_grid = seq(0.1, 0.9, by = 0.2),
                            x2_grid = seq(0.1, 0.9, by = 0.2),
                            tol = 1e-6) {
  violations <- data.frame(x1 = numeric(0), x2 = numeric(0),
                            rh1_X = numeric(0), rh1_Y = numeric(0))
  for (x1 in x1_grid) {
    for (x2 in x2_grid) {
      rhX <- biv_rhazard_gradient(x1, x2, cdf_fn = cdf_X)
      rhY <- biv_rhazard_gradient(x1, x2, cdf_fn = cdf_Y)
      if (rhX[1] > rhY[1] + tol || rhX[2] > rhY[2] + tol)
        violations <- rbind(violations,
                            data.frame(x1 = x1, x2 = x2,
                                       rh1_X = rhX[1], rh1_Y = rhY[1]))
    }
  }
  list(order_holds = nrow(violations) == 0L, violations = violations)
}

# ------------------------------------------------------------------------------
# Weak bivariate reversed MRL order (wrmrl)
# ------------------------------------------------------------------------------

#' Weak Bivariate Reversed Mean Residual Life Order
#'
#' @description
#' Checks \eqn{X \le_{\rm wrmrl} Y}:
#' \eqn{m_{i,X}(x_1,x_2) \ge m_{i,Y}(x_1,x_2),\; i=1,2}.
#'
#' @param cdf_X,cdf_Y Joint CDFs.
#' @param x1_grid,x2_grid Evaluation grids.
#' @param tol Tolerance.
#'
#' @return List with \code{order_holds} and \code{violations}.
#'
#' @examples
#' cX <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.1)
#' cY <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.8)
#' biv_wrmrl_order(cX, cY)
#'
#' @references
#' Jayalekshmi S., Rajesh G. — IJRQSE, Section 2.
#'
#' @export
biv_wrmrl_order <- function(cdf_X, cdf_Y,
                              x1_grid = seq(0.2, 0.8, by = 0.2),
                              x2_grid = seq(0.2, 0.8, by = 0.2),
                              tol = 1e-6) {
  violations <- data.frame(x1 = numeric(0), x2 = numeric(0),
                            m1_X = numeric(0), m1_Y = numeric(0))
  for (x1 in x1_grid) {
    for (x2 in x2_grid) {
      mX <- tryCatch(biv_rmrl(x1, x2, cdf_fn = cdf_X),
                     error = function(e) c(m1 = NA, m2 = NA))
      mY <- tryCatch(biv_rmrl(x1, x2, cdf_fn = cdf_Y),
                     error = function(e) c(m1 = NA, m2 = NA))
      if (!any(is.na(c(mX, mY))) &&
          (mX[1] < mY[1] - tol || mX[2] < mY[2] - tol))
        violations <- rbind(violations,
                            data.frame(x1 = x1, x2 = x2,
                                       m1_X = mX[1], m1_Y = mY[1]))
    }
  }
  list(order_holds = nrow(violations) == 0L, violations = violations)
}
