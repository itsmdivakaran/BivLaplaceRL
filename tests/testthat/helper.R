# Test helper: simple 1D integration wrapper
.integrate1d_test <- function(f, lo, hi) {
  stats::integrate(f, lo, hi, rel.tol = 1e-6)$value
}
