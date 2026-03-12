test_that("shannon_entropy of Exp(1) equals 1", {
  h <- shannon_entropy(function(x) dexp(x, rate = 1))
  expect_equal(h, 1, tolerance = 1e-3)
})

test_that("shannon_entropy of Exp(lambda) equals 1 - log(lambda)", {
  for (lam in c(0.5, 1, 2)) {
    h <- shannon_entropy(function(x) dexp(x, rate = lam))
    expect_equal(h, 1 - log(lam), tolerance = 1e-3)
  }
})

test_that("info_gen_function of Exp(1) at alpha=1 equals 1", {
  val <- info_gen_function(function(x) dexp(x, rate = 1), alpha = 1)
  expect_equal(val, 1, tolerance = 1e-3)
})

test_that("info_gen_function of Exp(lambda) at alpha=2 = lambda/2", {
  # int_0^infty (lambda * e^{-lambda*x})^2 dx = lambda^2 / (2*lambda) = lambda/2
  for (lam in c(0.5, 1, 2)) {
    val <- info_gen_function(function(x) dexp(x, rate = lam), alpha = 2)
    expect_equal(val, lam / 2, tolerance = 1e-3)
  }
})

test_that("residual_entropy at t=0 equals Shannon entropy", {
  f  <- function(x) dexp(x, 1)
  Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
  re <- residual_entropy(f, Fb, t = 0)
  sh <- shannon_entropy(f)
  expect_equal(re, sh, tolerance = 1e-3)
})

test_that("residual_entropy is finite for Exp(1) at positive t", {
  f  <- function(x) dexp(x, 1)
  Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
  re <- residual_entropy(f, Fb, t = 1)
  expect_true(is.finite(re))
})

test_that("residual_entropy is non-negative", {
  f  <- function(x) dexp(x, 1)
  Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
  for (t in c(0, 0.5, 1, 2)) {
    expect_gte(residual_entropy(f, Fb, t = t), 0)
  }
})

test_that("residual_info_gen at t=0 equals info_gen_function", {
  f  <- function(x) dexp(x, 1)
  Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
  for (a in c(1, 2, 0.5)) {
    ri <- residual_info_gen(f, Fb, alpha = a, t = 0)
    ig <- info_gen_function(f, alpha = a)
    expect_equal(ri, ig, tolerance = 1e-3)
  }
})

test_that("residual_info_gen is constant in t for Exp(1), alpha=2", {
  # For Exp(lambda), the REGF = lambda^(alpha-1)/alpha for all t >= 0.
  # This follows from the memoryless property: the conditional distribution of
  # (X - t | X > t) is again Exp(lambda), so I_alpha(t) = I_alpha(0) = 1/alpha.
  f  <- function(x) dexp(x, 1)
  Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
  vals <- sapply(0:3, function(t) residual_info_gen(f, Fb, alpha = 2, t = t))
  # All values should equal 1/alpha = 0.5
  expect_equal(vals, rep(0.5, 4L), tolerance = 1e-3)
})

test_that("np_residual_info_gen returns positive scalar", {
  set.seed(42)
  x <- rexp(200, rate = 1)
  val <- np_residual_info_gen(x, alpha = 2, t = 0)
  expect_true(is.numeric(val) && length(val) == 1 && val > 0)
})

test_that("np_residual_info_gen warns when no data > t", {
  set.seed(5)
  x <- rexp(50, rate = 1)
  expect_warning(np_residual_info_gen(x, alpha = 1, t = 1000))
})

test_that("sim_regf returns data frame with correct columns", {
  res <- sim_regf(lambda = 1, alpha = 2, t = 0, n_obs = 50, n_sim = 10)
  expect_s3_class(res, "data.frame")
  expect_named(res, c("true_value", "mean_est", "bias", "variance", "mse"))
})

test_that("regf_profile returns data frame", {
  f  <- function(x) dexp(x, 1)
  Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
  res <- regf_profile(f, Fb, alpha_grid = c(0.5, 1, 2), t = 0)
  expect_s3_class(res, "data.frame")
  expect_named(res, c("alpha", "REGF"))
  expect_equal(nrow(res), 3)
})

test_that("regf_characterise returns data frame with correct columns", {
  f  <- function(x) dexp(x, 1)
  Fb <- function(x) pexp(x, 1, lower.tail = FALSE)
  res <- regf_characterise(f, Fb, alpha = 2, t_grid = c(0, 0.5, 1))
  expect_s3_class(res, "data.frame")
  expect_named(res, c("t", "REGF", "log_REGF", "slope"))
})
