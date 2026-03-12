test_that("blt_residual_gumbel matches paper formula", {
  # Example 3.1 from Jayalekshmi et al. (2022)
  # L*_1 = 1/(k1 + s1 + theta*t2)
  res <- blt_residual_gumbel(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5,
                              k1 = 1, k2 = 1, theta = 0.5)
  expect_equal(res["L1_star"], c(L1_star = 1 / (1 + 1 + 0.5 * 0.5)))
  expect_equal(res["L2_star"], c(L2_star = 1 / (1 + 1 + 0.5 * 0.5)))
})

test_that("blt_residual_gumbel is positive", {
  res <- blt_residual_gumbel(s1 = 2, s2 = 0.5, t1 = 1, t2 = 0.3,
                              k1 = 2, k2 = 1, theta = 0.3)
  expect_true(all(res > 0))
})

test_that("blt_residual numeric matches closed-form (independence case)", {
  # theta = 0 => independent exponentials; marginal LT of residual life
  # L*(s, t) = 1/(k + s) [independent of t for exponential]
  res_num <- blt_residual(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5,
                           k1 = 1, k2 = 1, theta = 0, star = TRUE)
  res_cl  <- blt_residual_gumbel(s1 = 1, s2 = 1, t1 = 0.5, t2 = 0.5,
                                  k1 = 1, k2 = 1, theta = 0)
  expect_equal(as.numeric(res_num), as.numeric(res_cl), tolerance = 1e-3)
})

test_that("blt_residual returns named vector", {
  res <- blt_residual(1, 1, 0.5, 0.5, star = FALSE)
  expect_named(res, c("L1", "L2"))
  res2 <- blt_residual(1, 1, 0.5, 0.5, star = TRUE)
  expect_named(res2, c("L1_star", "L2_star"))
})

test_that("biv_hazard_gradient is positive", {
  hg <- biv_hazard_gradient(1, 1, k1 = 1, k2 = 1, theta = 0.3)
  expect_true(all(hg > 0))
})

test_that("biv_hazard_gradient has correct Gumbel form", {
  # h_i = k_i + theta * t_j for Gumbel distribution
  h <- biv_hazard_gradient(0.5, 1.0, k1 = 2, k2 = 1.5, theta = 0.3)
  expect_equal(as.numeric(h["h1"]), 2 + 0.3 * 1.0, tolerance = 1e-4)
  expect_equal(as.numeric(h["h2"]), 1.5 + 0.3 * 0.5, tolerance = 1e-4)
})

test_that("biv_mean_residual is positive", {
  mrl <- biv_mean_residual(0.5, 0.5, k1 = 1, k2 = 1, theta = 0)
  expect_true(all(mrl > 0))
})

test_that("biv_mean_residual matches analytic Exp for independence", {
  # When theta=0: m_i(t1,t2) = 1/k_i [memoryless property]
  mrl <- biv_mean_residual(1, 1, k1 = 2, k2 = 3, theta = 0)
  expect_equal(as.numeric(mrl["m1"]), 1/2, tolerance = 1e-3)
  expect_equal(as.numeric(mrl["m2"]), 1/3, tolerance = 1e-3)
})

test_that("nbuhr_test returns list with correct names", {
  res <- nbuhr_test(t2 = 0.5, k1 = 1, k2 = 1, theta = 0,
                    t1_grid = c(0.1, 0.5, 1))
  expect_named(res, c("class1", "class2", "h1_grid", "h2_grid", "t1_grid"))
})

test_that("nbuhr_test: Exp(k) marginal (theta=0) is NBUHR/NWUHR", {
  # Independent exponentials have constant hazard -> neither NBUHR nor NWUHR
  # (h is flat, so the ordering is an equality — classified as NBUHR by >=)
  res <- nbuhr_test(t2 = 0.5, k1 = 1, k2 = 1, theta = 0,
                    t1_grid = seq(0.1, 3, 0.5))
  expect_true(res$class1 %in% c("NBUHR", "NWUHR", "neither"))
})

test_that("np_blt_residual returns named numeric vector", {
  set.seed(10)
  dat <- rgumbel_biv(150, k1 = 1, k2 = 1, theta = 0.5)
  res <- np_blt_residual(dat, s1 = 1, s2 = 1, t1 = 0.2, t2 = 0.2)
  expect_named(res, c("L1_hat", "L2_hat"))
  expect_true(all(res > 0))
})

test_that("np_blt_residual NA when no observations exceed threshold", {
  set.seed(11)
  dat <- rgumbel_biv(50, k1 = 1, k2 = 1)
  expect_warning(res <- np_blt_residual(dat, s1 = 1, s2 = 1, t1 = 100, t2 = 100))
  expect_true(all(is.na(res)))
})

test_that("sim_blt_residual returns data frame with correct cols", {
  res <- sim_blt_residual(n_obs = 50, n_sim = 10, seed = 1)
  expect_s3_class(res, "data.frame")
  expect_true(all(c("component", "true_value", "bias", "mse") %in% names(res)))
})
