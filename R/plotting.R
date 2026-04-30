# ==============================================================================
# Plotting utilities
# ==============================================================================

#' Plot Bivariate Laplace Transform of Residual Lives
#'
#' @description
#' Plots the star Laplace transform of residual lives
#' \eqn{L^*_{X_{t_1|t_2}}(s_1)} as a function of \eqn{t_1} for fixed
#' \eqn{s_1}, \eqn{t_2}.  Optionally overlays two distributions for
#' visual comparison of the BLt-rl order.
#'
#' @param surv_fn Joint survival function.  If a second distribution is to be
#'   overlaid, pass it as \code{surv_fn2}.
#' @param surv_fn2 Optional second survival function for comparison.
#' @param s1 Laplace parameter (default 1).
#' @param t2 Fixed second truncation age (default 0.5).
#' @param t1_grid Grid of first truncation ages.
#' @param k1,k2,theta Parameters for the default Gumbel distribution; used
#'   only when \code{surv_fn = NULL}.
#' @param xlab,ylab,main Plot labels.
#' @param col1,col2 Line colours.
#' @param lwd Line width.
#' @param legend_labels Length-2 character vector for legend (ignored if
#'   \code{surv_fn2 = NULL}).
#'
#' @return Invisibly returns the data frame used for plotting.
#'
#' @examples
#' sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1, theta = 0.3)
#' sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 2, k2 = 1, theta = 0.3)
#' plot_blt_residual(sX, sY, s1 = 1, t2 = 0.5,
#'                   legend_labels = c("k1=1", "k1=2"))
#'
#' @export
plot_blt_residual <- function(surv_fn, surv_fn2 = NULL,
                               s1 = 1, t2 = 0.5,
                               t1_grid = seq(0.1, 3, by = 0.1),
                               k1 = 1, k2 = 1, theta = 0,
                               xlab = expression(t[1]),
                               ylab = expression(L^"*"[X[t[1]*"|"*t[2]]](s[1])),
                               main = "Bivariate LT of Residual Lives",
                               col1 = "steelblue", col2 = "firebrick",
                               lwd = 2,
                               legend_labels = c("Distribution 1",
                                                 "Distribution 2")) {
  if (is.null(surv_fn))
    surv_fn <- function(x1, x2) sgumbel_biv(x1, x2, k1, k2, theta)

  vals1 <- sapply(t1_grid, function(t1) {
    tryCatch(blt_residual(s1, s1, t1, t2, surv_fn = surv_fn, star = TRUE)[1],
             error = function(e) NA_real_)
  })

  df <- data.frame(t1 = t1_grid, L1_star = vals1)

  graphics::plot(t1_grid, vals1, type = "l", col = col1, lwd = lwd,
                 xlab = xlab, ylab = ylab, main = main)
  graphics::grid(col = "lightgray")

  if (!is.null(surv_fn2)) {
    vals2 <- sapply(t1_grid, function(t1) {
      tryCatch(blt_residual(s1, s1, t1, t2, surv_fn = surv_fn2, star = TRUE)[1],
               error = function(e) NA_real_)
    })
    graphics::lines(t1_grid, vals2, col = col2, lwd = lwd, lty = 2)
    df$L1_star2 <- vals2
    graphics::legend("topright", legend = legend_labels,
                     col = c(col1, col2), lty = c(1, 2), lwd = lwd, bty = "n")
  }
  invisible(df)
}

#' Plot Bivariate Laplace Transform of Reversed Residual Lives
#'
#' @description
#' Plots the reversed-life Laplace transform \eqn{L_{t_1|t_2}(s_1)} as a
#' function of \eqn{t_1} for fixed \eqn{s_1} and \eqn{t_2}.
#'
#' @param cdf_fn Joint CDF function.
#' @param cdf_fn2 Optional second CDF for comparison.
#' @param s1 Laplace parameter.
#' @param t2 Fixed second truncation time.
#' @param t1_grid Grid of first truncation times.
#' @param theta FGM parameter (used if \code{cdf_fn = NULL}).
#' @param xlab,ylab,main Plot labels.
#' @param col1,col2 Line colours.
#' @param lwd Line width.
#' @param legend_labels Legend labels.
#'
#' @return Invisibly returns the data frame used for plotting.
#'
#' @examples
#' cX <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.2)
#' cY <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.7)
#' plot_blt_reversed(cX, cY, s1 = 1, t2 = 0.5,
#'                   legend_labels = c("theta=0.2", "theta=0.7"))
#'
#' @export
plot_blt_reversed <- function(cdf_fn, cdf_fn2 = NULL,
                               s1 = 1, t2 = 0.5,
                               t1_grid = seq(0.1, 0.9, by = 0.05),
                               theta = 0,
                               xlab = expression(t[1]),
                               ylab = expression(L[t[1]*"|"*t[2]](s[1])),
                               main = "Bivariate LT of Reversed Residual Lives",
                               col1 = "darkgreen", col2 = "darkorange",
                               lwd = 2,
                               legend_labels = c("Distribution 1",
                                                 "Distribution 2")) {
  if (is.null(cdf_fn))
    cdf_fn <- function(x1, x2) pfgm_biv(x1, x2, theta)

  vals1 <- sapply(t1_grid, function(t1) {
    tryCatch(blt_reversed(s1, s1, t1, t2, cdf_fn = cdf_fn)[1],
             error = function(e) NA_real_)
  })
  df <- data.frame(t1 = t1_grid, L1 = vals1)

  graphics::plot(t1_grid, vals1, type = "l", col = col1, lwd = lwd,
                 xlab = xlab, ylab = ylab, main = main)
  graphics::grid(col = "lightgray")

  if (!is.null(cdf_fn2)) {
    vals2 <- sapply(t1_grid, function(t1) {
      tryCatch(blt_reversed(s1, s1, t1, t2, cdf_fn = cdf_fn2)[1],
               error = function(e) NA_real_)
    })
    graphics::lines(t1_grid, vals2, col = col2, lwd = lwd, lty = 2)
    df$L12 <- vals2
    graphics::legend("topright", legend = legend_labels,
                     col = c(col1, col2), lty = c(1, 2), lwd = lwd, bty = "n")
  }
  invisible(df)
}
