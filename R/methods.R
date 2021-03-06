#' @export
#' @import methods
print.covidseir <- function(x,
  pars = c("R0", "i0", "f_s", "start_decline", "end_decline", "phi"), ...) {
  if ("fit_type" %in% names(x)) {
    if (x$fit_type == "optimizing") {
      phi_n <- grep("phi\\[", colnames(x$fit$theta_tilde))
      cat("MAP estimate:\n")
      print(round(x$fit$par[seq_len(phi_n)], 2), ...)
      cat("Mean in constrained space of MVN samples:\n")
      print(apply(x$fit$theta_tilde[,seq_len(phi_n)], 2, function(y) round(mean(y), 2)), ...)
      cat("SD in constrained space of MVN samples:\n")
      print(apply(x$fit$theta_tilde[,seq_len(phi_n)], 2, function(y) round(stats::sd(y), 2)), ...)
    } else {
      print(x$fit, pars = pars, ...)
    }
  } else {
    warning("This model was fit with an old version of covidseir.", call. = FALSE)
    print(x$fit, pars = pars, ...)
  }
}
