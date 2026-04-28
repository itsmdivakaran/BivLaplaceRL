# ==============================================================================
# Entropy and Information Generating Function
# Reference: Smitha S., Rajesh G., Jayalekshmi S. (2024) JISA 62(1):81-93
# ==============================================================================

# ------------------------------------------------------------------------------
# Shannon entropy
# ------------------------------------------------------------------------------

#' Shannon Differential Entropy
#'
#' @description
#' Computes the Shannon differential entropy
#' \deqn{H(f) = -\int_0^\infty f(x)\log f(x)\,dx}
#' for a non-negative continuous random variable with density \code{dens_fn}.
#'
#' @param dens_fn A function of one argument returning the density \eqn{f(x)}.
#' @param upper Upper integration limit (default 100).
#'
#' @return Scalar numeric.
#'
#' @examples
#' # Exponential(1): H = 1
#' shannon_entropy(function(x) dexp(x, rate = 1))
#'
#' # Exponential(2): H = 1 - log(2)
#' shannon_entropy(function(x) dexp(x, rate = 2))
#'
#' @references
#' Shannon C.E. (1948). A mathematical theory of communication. *Bell System
#' Technical Journal*, 27(3), 379--423.
#'
#' Smitha S., Rajesh G., Jayalekshmi S. (2024). *Journal of the Indian
#' Statistical Association*, 62(1), 81--93.
#'
#' @seealso \code{\link{residual_entropy}}, \code{\link{info_gen_function}}
#' @export
shannon_entropy <- function(dens_fn, upper = 100) {
  integrand <- function(x) {
    fx <- dens_fn(x)
    ifelse(fx > 0, -fx * log(fx), 0)
  }
  .integrate1d(integrand, 0, upper)
}

# ------------------------------------------------------------------------------
# Golomb information generating function
# ------------------------------------------------------------------------------

#' Golomb Information Generating Function
#'
#' @description
#' Computes the information generating function (IGF) introduced by Golomb
#' (1966):
#' \deqn{\mathcal{I}_\alpha(f) = \int_0^\infty f^\alpha(x)\,dx, \quad \alpha > 0.}
#'
#' When \eqn{\alpha \to 1},
#' \eqn{-d\mathcal{I}_\alpha / d\alpha|_{\alpha=1} = H(f)}.
#'
#' @param dens_fn A function of one argument returning the density.
#' @param alpha Positive parameter (default 1).
#' @param upper Upper integration limit.
#'
#' @return Scalar numeric.
#'
#' @examples
#' # Exponential(1) with alpha=1 gives 1
#' info_gen_function(function(x) dexp(x, rate = 1), alpha = 1)
#'
#' # alpha = 2
#' info_gen_function(function(x) dexp(x, rate = 1), alpha = 2)
#'
#' @references
#' Golomb S.W. (1966). The information generating function of a probability
#' distribution. *IEEE Transactions on Information Theory*, 12(1), 75--77.
#'
#' @seealso \code{\link{residual_info_gen}}
#' @export
info_gen_function <- function(dens_fn, alpha = 1, upper = 100) {
  .check_positive(alpha, "alpha")
  integrand <- function(x) {
    fx <- dens_fn(x)
    ifelse(fx > 0, fx^alpha, 0)
  }
  .integrate1d(integrand, 0, upper)
}

# ------------------------------------------------------------------------------
# Residual entropy (Ebrahimi & Pellerey 1995)
# ------------------------------------------------------------------------------

#' Residual Entropy Function
#'
#' @description
#' Computes the residual entropy (dynamic entropy) introduced by Ebrahimi and
#' Pellerey (1995):
#' \deqn{H(X; t) = -\int_t^\infty \frac{f(x)}{\bar{F}(t)}
#'   \log\frac{f(x)}{\bar{F}(t)}\,dx, \quad t \ge 0.}
#'
#' @param dens_fn Density function \eqn{f(x)}.
#' @param surv_fn Survival function \eqn{\bar{F}(x)}; if \code{NULL} it is
#'   computed from \code{dens_fn} by integration.
#' @param t Truncation time (default 0, which returns Shannon entropy).
#' @param upper Upper integration limit.
#'
#' @return Scalar numeric.
#'
#' @examples
#' # Exponential(1)
#' f  <- function(x) dexp(x, 1)
#' Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
#' residual_entropy(f, Fb, t = 0)   # = 1
#' residual_entropy(f, Fb, t = 1)   # = 1 + exp(-1) * log(exp(1)-1) or similar
#'
#' @references
#' Ebrahimi N., Pellerey F. (1995). New partial ordering of survival functions
#' based on the notion of uncertainty. *Journal of Applied Probability*, 32(1),
#' 202--211.
#'
#' @seealso \code{\link{residual_info_gen}}, \code{\link{shannon_entropy}}
#' @export
residual_entropy <- function(dens_fn, surv_fn = NULL, t = 0, upper = 100) {
  .check_nonneg(t, "t")
  if (is.null(surv_fn)) {
    surv_fn <- function(x) .integrate1d(dens_fn, x, upper)
  }
  Ft <- surv_fn(t)
  if (Ft <= 0) {
    warning("surv_fn(t) = 0; returning NA.")
    return(NA_real_)
  }
  integrand <- function(x) {
    fx <- dens_fn(x)
    ratio <- fx / Ft
    ifelse(ratio > 0, -ratio * log(ratio), 0)
  }
  .integrate1d(integrand, t, upper)
}

# ------------------------------------------------------------------------------
# Residual entropy generating function (REGF) — main new measure
# ------------------------------------------------------------------------------

#' Residual Entropy Generating Function (REGF)
#'
#' @description
#' Computes the residual entropy generating function proposed by Smitha,
#' Rajesh, and Jayalekshmi (2024):
#' \deqn{\mathcal{I}_\alpha(X; t) = \int_t^\infty
#'   \left(\frac{f(x)}{\bar{F}(t)}\right)^\alpha dx, \quad \alpha > 0,\; t \ge 0.}
#'
#' Note that:
#' \itemize{
#'   \item At \eqn{t = 0}, \eqn{\mathcal{I}_\alpha(X;0) = \mathcal{I}_\alpha(f)},
#'     Golomb's IGF.
#'   \item \eqn{-\partial \mathcal{I}_\alpha/\partial\alpha|_{\alpha=1} = H(X;t)},
#'     the residual entropy.
#' }
#'
#' @param dens_fn Density function \eqn{f(x)}.
#' @param surv_fn Survival function \eqn{\bar{F}(x)}; computed by integration
#'   if \code{NULL}.
#' @param alpha Positive parameter (default 1).
#' @param t Truncation time (default 0).
#' @param upper Upper integration limit.
#'
#' @return Scalar numeric.
#'
#' @examples
#' f  <- function(x) dexp(x, 1)
#' Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
#'
#' # At t=0, alpha=1: should equal 1
#' residual_info_gen(f, Fb, alpha = 1, t = 0)
#'
#' # Dynamic version at t = 0.5
#' residual_info_gen(f, Fb, alpha = 2, t = 0.5)
#'
#' # Derivative recovers residual entropy
#' (residual_info_gen(f, Fb, alpha = 1 + 1e-5, t = 0) -
#'   residual_info_gen(f, Fb, alpha = 1, t = 0)) / 1e-5   # approx -H(f)
#'
#' @references
#' Smitha S., Rajesh G., Jayalekshmi S. (2024). On residual entropy generating
#' function. *Journal of the Indian Statistical Association*, 62(1), 81--93.
#'
#' @seealso \code{\link{info_gen_function}}, \code{\link{residual_entropy}},
#'   \code{\link{np_residual_info_gen}}
#' @export
residual_info_gen <- function(dens_fn, surv_fn = NULL,
                               alpha = 1, t = 0, upper = 100) {
  .check_positive(alpha, "alpha")
  .check_nonneg(t, "t")
  if (is.null(surv_fn)) {
    surv_fn <- function(x) .integrate1d(dens_fn, x, upper)
  }
  Ft <- surv_fn(t)
  if (Ft <= 0) {
    warning("surv_fn(t) = 0; returning NA.")
    return(NA_real_)
  }
  integrand <- function(x) {
    fx <- dens_fn(x)
    (fx / Ft)^alpha
  }
  .integrate1d(integrand, t, upper)
}

# ------------------------------------------------------------------------------
# REGF profile across alpha
# ------------------------------------------------------------------------------

#' REGF Profile Over Alpha
#'
#' @description
#' Evaluates \code{\link{residual_info_gen}} over a grid of \eqn{\alpha} values
#' and optionally plots the result.  Useful for studying how the information
#' content varies with the Renyi-type parameter.
#'
#' @param dens_fn Density function.
#' @param surv_fn Survival function; computed internally if \code{NULL}.
#' @param alpha_grid Numeric vector of \eqn{\alpha} values (default 0.1 to 3).
#' @param t Truncation time.
#' @param upper Integration upper bound.
#' @param plot Logical; if \code{TRUE} plots the profile (default \code{FALSE}).
#'
#' @return A data frame with columns \code{alpha} and \code{REGF}.
#'
#' @examples
#' f  <- function(x) dexp(x, 1)
#' Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
#' regf_profile(f, Fb, t = 0.5, plot = FALSE)
#'
#' @export
regf_profile <- function(dens_fn, surv_fn = NULL,
                          alpha_grid = seq(0.1, 3, by = 0.2),
                          t = 0, upper = 100, plot = FALSE) {
  vals <- sapply(alpha_grid, function(a)
    residual_info_gen(dens_fn, surv_fn, alpha = a, t = t, upper = upper))
  result <- data.frame(alpha = alpha_grid, REGF = vals)
  if (plot) {
    graphics::plot(alpha_grid, vals, type = "l",
                   xlab = expression(alpha),
                   ylab = expression(I[alpha](X * ";" * t)),
                   main = paste0("REGF profile at t = ", t))
    graphics::grid()
  }
  invisible(result)
}

# ------------------------------------------------------------------------------
# Nonparametric estimator for REGF
# ------------------------------------------------------------------------------

#' Nonparametric Estimator for the Residual Entropy Generating Function
#'
#' @description
#' Given a univariate sample \eqn{X_1,\ldots,X_n}, estimates the REGF using a
#' kernel density estimator for \eqn{f} and the empirical survival function for
#' \eqn{\bar{F}(t)}:
#' \deqn{\hat{\mathcal{I}}_\alpha(t)
#'   = \sum_{i:X_i > t} \frac{\hat{f}(X_i)^{\alpha - 1}}{(n\,\hat{F}_n(t))^\alpha}
#'   \cdot \frac{1}{n}}
#' where \eqn{\hat{f}} is a Gaussian kernel density estimator.
#'
#' @param x Numeric vector; observed sample.
#' @param alpha Positive parameter (default 1).
#' @param t Truncation time (default 0).
#' @param bw Bandwidth for KDE; uses \code{\link[stats]{bw.nrd0}} if
#'   \code{NULL}.
#'
#' @return Scalar numeric estimate of REGF.
#'
#' @examples
#' set.seed(1)
#' x <- rexp(100, rate = 1)
#' np_residual_info_gen(x, alpha = 2, t = 0)
#'
#' # Compare with true value
#' f  <- function(x) dexp(x, 1)
#' Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
#' residual_info_gen(f, Fb, alpha = 2, t = 0)
#'
#' @references
#' Smitha S., Rajesh G., Jayalekshmi S. (2024), Section 4.
#' *Journal of the Indian Statistical Association*, 62(1), 81--93.
#'
#' @seealso \code{\link{residual_info_gen}}, \code{\link{sim_regf}}
#' @export
np_residual_info_gen <- function(x, alpha = 1, t = 0, bw = NULL) {
  .check_positive(alpha, "alpha")
  .check_nonneg(t, "t")
  x <- x[!is.na(x)]
  n <- length(x)
  if (n < 5L) stop("Need at least 5 observations.")

  if (is.null(bw)) bw <- stats::bw.nrd0(x)
  Ft_hat <- mean(x > t)
  if (Ft_hat <= 0) {
    warning("No observations exceed t; returning NA.")
    return(NA_real_)
  }

  xi_gt <- x[x > t]
  if (length(xi_gt) == 0L) return(NA_real_)

  f_hat <- .kde_eval(x, xi_gt, bw = bw)
  # I_alpha(t) = int_{t}^{inf} (f(x)/Ft)^alpha dx
  # Approximated by: (1/n) * sum_{Xi > t} (f_hat(Xi)/Ft_hat)^alpha / f_hat(Xi)
  # = (1/n) * sum f_hat^(alpha-1) / Ft_hat^alpha
  sum((f_hat / Ft_hat)^alpha / pmax(f_hat, .Machine$double.eps) *
        (1 / n))
}

# ------------------------------------------------------------------------------
# Simulation study for REGF estimator
# ------------------------------------------------------------------------------

#' Monte-Carlo Simulation for the REGF Nonparametric Estimator
#'
#' @description
#' Evaluates the performance of \code{\link{np_residual_info_gen}} via repeated
#' simulation from the exponential distribution and compares to the true REGF
#' \eqn{\mathcal{I}_\alpha(\text{Exp}(\lambda); t) =
#'   \lambda^{\alpha-1} e^{(\alpha-1)\lambda t} / (\alpha-1)}.
#'
#' @param lambda Exponential rate.
#' @param alpha REGF parameter.
#' @param t Truncation time.
#' @param n_obs Sample size per replicate.
#' @param n_sim Number of replicates.
#' @param seed Random seed.
#'
#' @return A data frame with \code{true_value}, \code{mean_est}, \code{bias},
#'   \code{variance}, \code{mse}.
#'
#' @examples
#' sim_regf(lambda = 1, alpha = 2, t = 0, n_obs = 100, n_sim = 30)
#'
#' @references
#' Smitha S., Rajesh G., Jayalekshmi S. (2024), Section 4.
#'
#' @seealso \code{\link{np_residual_info_gen}}
#' @export
sim_regf <- function(lambda = 1, alpha = 2, t = 0,
                      n_obs = 200, n_sim = 100, seed = 42L) {
  .check_positive(lambda, "lambda")
  .check_positive(alpha, "alpha")
  set.seed(seed)

  # True REGF for Exp(lambda): by the memoryless property, (X-t|X>t) ~ Exp(lambda)
  # so I_alpha(t) = integral_0^inf (lambda * e^{-lambda*u})^alpha du = lambda^(alpha-1)/alpha
  # This is constant in t for all alpha != 1.
  # At alpha = 1 the limit gives the Shannon residual entropy = log(1/lambda) + 1.
  true_val <- if (abs(alpha - 1) < 1e-10) {
    log(1 / lambda) + 1   # Shannon entropy of Exp(lambda)
  } else {
    lambda^(alpha - 1) / alpha
  }

  ests <- replicate(n_sim, {
    samp <- stats::rexp(n_obs, rate = lambda)
    np_residual_info_gen(samp, alpha = alpha, t = t)
  })

  bias <- mean(ests, na.rm = TRUE) - true_val
  vr   <- stats::var(ests, na.rm = TRUE)
  data.frame(
    true_value = true_val,
    mean_est   = mean(ests, na.rm = TRUE),
    bias       = bias,
    variance   = vr,
    mse        = bias^2 + vr
  )
}

# ------------------------------------------------------------------------------
# Distribution characterisation via REGF
# ------------------------------------------------------------------------------

#' Characterise a Distribution via the REGF
#'
#' @description
#' Checks whether the functional form of \eqn{\mathcal{I}_\alpha(X;t)} over a
#' grid of \eqn{t} values is consistent with an exponential distribution.  For
#' \eqn{X \sim \text{Exp}(\lambda)},
#' \eqn{\mathcal{I}_\alpha(t) / \mathcal{I}_\alpha(0) = e^{(\alpha-1)\lambda t}},
#' a pure exponential in \eqn{t}.
#'
#' @param dens_fn Density function.
#' @param surv_fn Survival function.
#' @param alpha REGF parameter.
#' @param t_grid Grid of truncation times.
#' @param upper Integration upper bound.
#'
#' @return A data frame with columns \code{t}, \code{REGF}, \code{log_REGF},
#'   and the fitted linear-in-\eqn{t} slope \code{slope} (log-linear
#'   characterisation).
#'
#' @examples
#' f  <- function(x) dexp(x, 1)
#' Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
#' regf_characterise(f, Fb, alpha = 2)
#'
#' @references
#' Smitha S., Rajesh G., Jayalekshmi S. (2024), Section 3.
#'
#' @export
regf_characterise <- function(dens_fn, surv_fn = NULL, alpha = 2,
                               t_grid = seq(0, 2, by = 0.2),
                               upper = 100) {
  vals <- sapply(t_grid, function(t)
    residual_info_gen(dens_fn, surv_fn, alpha = alpha, t = t, upper = upper))
  log_vals <- .safe_log(vals / vals[1])
  # Fit log(I_alpha(t)) = beta * t via simple regression
  fit  <- if (sum(!is.na(log_vals)) > 1)
    unname(stats::lm(log_vals ~ t_grid)$coefficients[2])
  else NA_real_

  data.frame(t = t_grid, REGF = vals, log_REGF = log_vals, slope = fit,
             row.names = NULL)
}
