# ==============================================================================
# Internal Utility Functions
# ==============================================================================

# Parameter checking helpers ---------------------------------------------------

.check_positive <- function(x, name) {
  if (!is.numeric(x) || length(x) != 1L || x <= 0)
    stop(sprintf("`%s` must be a single positive number.", name))
}

.check_nonneg <- function(x, name) {
  if (!is.numeric(x) || length(x) != 1L || x < 0)
    stop(sprintf("`%s` must be a single non-negative number.", name))
}

.check_range <- function(x, lo, hi, name) {
  if (!is.numeric(x) || length(x) != 1L || x < lo || x > hi)
    stop(sprintf("`%s` must be a single number in [%g, %g].", name, lo, hi))
}

# Numerical integration wrapper ------------------------------------------------

#' One-dimensional numerical integration using stats::integrate
#' @noRd
.integrate1d <- function(f, lower, upper, ..., tol = 1e-8, max_eval = 1e5) {
  if (lower >= upper) return(0)
  res <- tryCatch(
    stats::integrate(f, lower = lower, upper = upper,
                     rel.tol = tol, abs.tol = tol,
                     subdivisions = as.integer(max_eval), ...),
    error = function(e) list(value = NA_real_, message = conditionMessage(e))
  )
  if (is.na(res$value))
    warning("Numerical integration may have failed: ", res$message)
  res$value
}

# Empirical CDF / survival -----------------------------------------------------

#' Empirical bivariate survival function
#' @noRd
.biv_surv_empirical <- function(data, t1, t2) {
  mean(data[, 1] > t1 & data[, 2] > t2)
}

#' Empirical bivariate CDF
#' @noRd
.biv_cdf_empirical <- function(data, t1, t2) {
  mean(data[, 1] <= t1 & data[, 2] <= t2)
}

# Kernel density estimator (univariate, for REGF) ------------------------------

#' Kernel density at a grid of points (Gaussian, bandwidth = bw.nrd0)
#' @noRd
.kde_eval <- function(x, eval_pts, bw = stats::bw.nrd0(x)) {
  n <- length(x)
  sapply(eval_pts, function(t) mean(stats::dnorm((t - x) / bw)) / bw)
}

# Safe logarithm ---------------------------------------------------------------
.safe_log <- function(x) log(pmax(x, .Machine$double.eps))
