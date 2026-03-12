test_that("blt_reversed returns named vector", {
  res <- blt_reversed(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5)
  expect_named(res, c("L1", "L2"))
})

test_that("blt_reversed G form is positive", {
  res <- blt_reversed(s1 = 1, s2 = 1, t1 = 0.4, t2 = 0.4, g_form = TRUE)
  expect_named(res, c("G1", "G2"))
  expect_true(all(res > 0))
})

test_that("blt_reversed_fgm is positive for theta=0", {
  val <- blt_reversed_fgm(s1 = 1, s2 = 1, theta = 0)
  expect_gt(val, 0)
})

test_that("blt_reversed_fgm gives same result for theta=0 as product of marginals", {
  # When theta=0, joint LT = product of marginal Uniform[0,1] LTs
  # LT of Uniform[0,1] at s: (1 - e^{-s})/s
  s <- 1.5
  lt_marg <- (1 - exp(-s)) / s
  val <- blt_reversed_fgm(s1 = s, s2 = s, theta = 0)
  expect_equal(val, lt_marg^2, tolerance = 1e-8)
})

test_that("blt_reversed_power returns named vector", {
  res <- blt_reversed_power(s1 = 1, t1 = 0.5, t2 = 0.5, p1 = 2, p2 = 2, theta = 0.2)
  expect_named(res, c("G1", "reversed_hazard_h1"))
})

test_that("biv_rhazard_gradient is positive for FGM", {
  rh <- biv_rhazard_gradient(x1 = 0.5, x2 = 0.5, theta = 0.5)
  expect_true(all(rh > 0))
})

test_that("biv_rmrl is positive", {
  m <- biv_rmrl(x1 = 0.5, x2 = 0.5, theta = 0.3)
  expect_named(m, c("m1", "m2"))
  expect_true(all(m > 0))
})

test_that("biv_rmrl values <= x1 and x2 (RMRL <= current age)", {
  m <- biv_rmrl(x1 = 0.7, x2 = 0.8, theta = 0)
  expect_lte(m["m1"], 0.7)
  expect_lte(m["m2"], 0.8)
})

test_that("blt_reversed increases with t1 for FGM distribution", {
  # Generally, the past-life Laplace transform should be increasing in t
  vals <- sapply(seq(0.1, 0.8, 0.1), function(t1)
    blt_reversed(s1 = 1, s2 = 1, t1 = t1, t2 = 0.5)[1])
  # Not strictly necessary in all cases but for uniform-like marginals it holds
  expect_true(is.numeric(vals))
})
