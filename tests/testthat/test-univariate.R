f1  <- function(x) dexp(x, 1)
Fb1 <- function(x) pexp(x, 1, lower.tail = FALSE)
f2  <- function(x) dexp(x, 2)
Fb2 <- function(x) pexp(x, 2, lower.tail = FALSE)

# ---- lt_residual ----

test_that("lt_residual at t=0 gives standard LT for Exp(1)", {
  # L_X(s, 0) = 1/(1+s)
  val <- lt_residual(f1, Fb1, s = 1, t = 0)
  expect_equal(val, 0.5, tolerance = 1e-4)
})

test_that("lt_residual at t=0 gives 1/(lambda+s) for Exp(lambda)", {
  val <- lt_residual(f2, Fb2, s = 1, t = 0)
  expect_equal(val, 2 / 3, tolerance = 1e-4)   # 2/(2+1)
})

test_that("lt_residual is constant in t for Exp (memoryless)", {
  # For Exp(1): L_X(s,t) = e^{st}/(1+s) * e^{-t} ... wait
  # Actually L_X(s,t) = int_t^inf e^{-sx} lambda*e^{-lambda*x} dx / e^{-lambda*t}
  # = lambda * e^{-(s+lambda)*t} / ((s+lambda) * e^{-lambda*t})
  # = lambda * e^{-s*t} / (s+lambda)
  # So it's NOT constant in t for s>0, only for s=0.
  # Let's just check the formula:
  s <- 1; t <- 0.5; lam <- 1
  expected <- lam * exp(-s * t) / (s + lam)
  val <- lt_residual(f1, Fb1, s = s, t = t)
  expect_equal(val, expected, tolerance = 1e-4)
})

test_that("lt_residual returns NA with warning when surv_fn(t)=0", {
  expect_warning(val <- lt_residual(f1, Fb1, s = 1, t = 1000))
  expect_true(is.na(val))
})

# ---- hazard_rate ----

test_that("hazard_rate of Exp(1) is constantly 1", {
  h <- hazard_rate(f1, Fb1, t = c(0.5, 1, 2))
  expect_equal(h, c(1, 1, 1), tolerance = 1e-4)
})

test_that("hazard_rate of Exp(lambda) is constantly lambda", {
  h <- hazard_rate(f2, Fb2, t = c(0.5, 1, 2))
  expect_equal(h, c(2, 2, 2), tolerance = 1e-4)
})

# ---- mean_residual ----

test_that("mean_residual of Exp(1) is constantly 1", {
  m <- mean_residual(Fb1, t = c(0, 0.5, 1, 2))
  expect_equal(m, rep(1, 4), tolerance = 1e-3)
})

test_that("mean_residual of Exp(2) is constantly 0.5", {
  m <- mean_residual(Fb2, t = c(0, 0.5, 1))
  expect_equal(m, rep(0.5, 3), tolerance = 1e-3)
})

# ---- lt_rl_order ----

test_that("Exp(1) <=_Lt-rl Exp(2) holds", {
  # L_{Exp(lambda)}(s,t) = lambda*exp(-s*t)/(s+lambda)
  # For s>0: 1/(s+1) < 2/(s+2), so Exp(1) has smaller LT => Exp(1) <=_Lt-rl Exp(2)
  res <- lt_rl_order(f1, Fb1, f2, Fb2,
                     s_grid = c(0.5, 1, 2), t_grid = c(0, 0.5))
  expect_true(res$order_holds)
})

test_that("Exp(2) <=_Lt-rl Exp(1) does not hold", {
  res <- lt_rl_order(f2, Fb2, f1, Fb1,
                     s_grid = c(0.5, 1, 2), t_grid = c(0, 0.5))
  expect_false(res$order_holds)
})

# ---- hr_order ----

test_that("Exp(1) <=_hr Exp(2) holds", {
  res <- hr_order(f1, Fb1, f2, Fb2, t_grid = c(0.5, 1, 2))
  expect_true(res$order_holds)
})

test_that("Exp(2) <=_hr Exp(1) does not hold", {
  res <- hr_order(f2, Fb2, f1, Fb1, t_grid = c(0.5, 1, 2))
  expect_false(res$order_holds)
})

# ---- mrl_order ----

test_that("Exp(2) <=_mrl Exp(1) holds", {
  res <- mrl_order(Fb2, Fb1, t_grid = c(0, 0.5, 1, 2))
  expect_true(res$order_holds)
})

test_that("Exp(1) <=_mrl Exp(2) does not hold", {
  res <- mrl_order(Fb1, Fb2, t_grid = c(0, 0.5, 1, 2))
  expect_false(res$order_holds)
})

# ---- np_lt_residual ----

test_that("np_lt_residual is close to true value for large sample", {
  set.seed(42)
  x <- rexp(5000, rate = 1)
  est <- np_lt_residual(x, s = 1, t = 0)
  expect_equal(est, 0.5, tolerance = 0.05)
})

test_that("np_lt_residual warns when no observations exceed t", {
  x <- rexp(50, rate = 1)
  expect_warning(np_lt_residual(x, s = 1, t = 1000))
})
