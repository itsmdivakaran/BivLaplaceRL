test_that("sgumbel_biv returns 1 at origin", {
  expect_equal(sgumbel_biv(0, 0, k1 = 1, k2 = 1, theta = 0.5), 1)
})

test_that("sgumbel_biv is non-negative and <= 1", {
  vals <- outer(seq(0, 3, 0.5), seq(0, 3, 0.5),
                function(x, y) sgumbel_biv(x, y, 1, 1, 0.3))
  expect_true(all(vals >= 0 & vals <= 1))
})

test_that("sgumbel_biv decreases in both arguments", {
  s1 <- sgumbel_biv(0.5, 1, 1, 1, 0.3)
  s2 <- sgumbel_biv(1.0, 1, 1, 1, 0.3)
  s3 <- sgumbel_biv(0.5, 2, 1, 1, 0.3)
  expect_gt(s1, s2)
  expect_gt(s1, s3)
})

test_that("dgumbel_biv integrates to approx 1 (independence case)", {
  # Double-integrate using nested stats::integrate (no extra packages needed).
  # The outer integrand must be Vectorized so stats::integrate can pass vectors.
  inner <- function(x2, x1_val)
    stats::integrate(function(x2v) dgumbel_biv(x1_val, x2v, k1 = 1, k2 = 1, theta = 0),
                     0, 10, rel.tol = 1e-5)$value
  outer_fn <- Vectorize(function(x1) inner(0, x1))
  intg <- stats::integrate(outer_fn, 0, 10, rel.tol = 1e-5)$value
  expect_equal(intg, 1, tolerance = 1e-3)
})

test_that("rgumbel_biv returns correct dimensions", {
  set.seed(1)
  dat <- rgumbel_biv(50, 1, 1, 0.3)
  expect_equal(dim(dat), c(50L, 2L))
  expect_true(all(dat >= 0))
})

test_that("pgumbel_biv gives CDF in [0,1]", {
  vals <- pgumbel_biv(seq(0.1, 3, 0.5), seq(0.1, 3, 0.5))
  expect_true(all(vals >= 0 & vals <= 1))
})

test_that("pfgm_biv satisfies boundary conditions", {
  expect_equal(pfgm_biv(0, 0.5, theta = 0.5), 0)
  expect_equal(pfgm_biv(0.5, 0, theta = 0.5), 0)
})

test_that("rfgm_biv returns matrix with values in [0,1]", {
  set.seed(2)
  dat <- rfgm_biv(100, theta = 0.5)
  expect_equal(ncol(dat), 2L)
  expect_true(all(dat >= 0 & dat <= 1))
})

test_that("dfgm_biv integrates to 1", {
  # Outer function must be Vectorized so stats::integrate can pass a vector.
  inner_fn <- function(x1_val)
    stats::integrate(function(x2) dfgm_biv(x1_val, x2, theta = 0.3),
                     0, 1, rel.tol = 1e-6)$value
  outer_fn <- Vectorize(inner_fn)
  val <- stats::integrate(outer_fn, 0, 1, rel.tol = 1e-6)$value
  expect_equal(val, 1, tolerance = 1e-4)
})

test_that("sschur_biv is symmetric", {
  v1 <- sschur_biv(0.5, 1.0, lambda = 1)
  v2 <- sschur_biv(1.0, 0.5, lambda = 1)
  expect_equal(v1, v2)
})

test_that("rschur_biv has non-negative entries", {
  set.seed(3)
  dat <- rschur_biv(50, lambda = 2)
  expect_true(all(dat >= 0))
})

test_that("pbivpower returns 0 when any argument is 0", {
  expect_equal(pbivpower(0, 0.5), 0)
  expect_equal(pbivpower(0.5, 0), 0)
})

test_that("rbivpower returns positive values", {
  set.seed(4)
  dat <- rbivpower(50, p1 = 2, p2 = 2)
  expect_true(all(dat >= 0))
})
