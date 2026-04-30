# ==============================================================================
# Entropy and Information Generating Functions
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
#' @seealso \code{\link{info_gen_function}}
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
#' @seealso \code{\link{shannon_entropy}}
#' @export
info_gen_function <- function(dens_fn, alpha = 1, upper = 100) {
  .check_positive(alpha, "alpha")
  integrand <- function(x) {
    fx <- dens_fn(x)
    ifelse(fx > 0, fx^alpha, 0)
  }
  .integrate1d(integrand, 0, upper)
}
