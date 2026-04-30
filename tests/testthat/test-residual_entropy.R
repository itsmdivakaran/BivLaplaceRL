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
