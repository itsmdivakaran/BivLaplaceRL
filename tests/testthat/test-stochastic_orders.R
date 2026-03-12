test_that("blt_order_residual: same distribution yields no violations", {
  sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1, theta = 0.3)
  res <- blt_order_residual(sX, sX, s1 = 1, s2 = 1,
                             t1_grid = c(0.5, 1), t2_grid = c(0.5, 1))
  expect_true(res$order_holds)
})

test_that("blt_order_residual returns list with correct elements", {
  sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1)
  sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 2, k2 = 2)
  res <- blt_order_residual(sX, sY, t1_grid = 0.5, t2_grid = 0.5)
  expect_named(res, c("order_holds", "violations", "ratio_matrix"))
})

test_that("blt_order_reversed: same distribution yields no violations", {
  cX <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.4)
  res <- blt_order_reversed(cX, cX, s1 = 1, s2 = 1,
                             t1_grid = c(0.2, 0.5), t2_grid = c(0.2, 0.5))
  expect_true(res$order_holds)
})

test_that("biv_whr_order: X <=_whr Y when k_X > k_Y (Gumbel, theta=0)", {
  # Higher k => higher hazard => X <=_whr Y when h_X >= h_Y
  sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 2, k2 = 2, theta = 0)
  sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1, theta = 0)
  res <- biv_whr_order(sX, sY, t1_grid = c(0.5, 1), t2_grid = c(0.5, 1))
  expect_true(res$order_holds)
})

test_that("biv_whr_order returns correct structure", {
  sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1)
  sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1)
  res <- biv_whr_order(sX, sY, t1_grid = 0.5, t2_grid = 0.5)
  expect_named(res, c("order_holds", "violations"))
})

test_that("biv_wmrl_order: X <=_wmrl Y when X stoch smaller (Exp theta=0)", {
  # k_X > k_Y => E[X_i] < E[Y_i] => MRL_X <= MRL_Y
  sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 2, k2 = 2, theta = 0)
  sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1, theta = 0)
  res <- biv_wmrl_order(sX, sY, t1_grid = c(0.2, 0.5), t2_grid = c(0.2))
  expect_true(res$order_holds)
})

test_that("biv_brlmr_order: returns list", {
  sX <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 1, k2 = 1)
  sY <- function(x1, x2) sgumbel_biv(x1, x2, k1 = 0.5, k2 = 0.5)
  res <- biv_brlmr_order(sX, sY, t2_fixed = 0.5, t1_grid = c(0.5, 1))
  expect_named(res, c("order_holds", "ratio_values", "t1_grid"))
})

test_that("biv_wrhr_order: same distribution holds", {
  cX <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.3)
  res <- biv_wrhr_order(cX, cX, x1_grid = c(0.2, 0.5), x2_grid = c(0.2, 0.5))
  expect_true(res$order_holds)
})

test_that("biv_wrmrl_order: same distribution holds", {
  cX <- function(x1, x2) pfgm_biv(x1, x2, theta = 0.5)
  res <- biv_wrmrl_order(cX, cX, x1_grid = c(0.3, 0.6), x2_grid = c(0.3))
  expect_true(res$order_holds)
})
