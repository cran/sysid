% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{armaxsim}
\alias{armaxsim}
\title{Data simulated from an ARMAX model}
\format{an \code{idframe} object with 2555 samples, one input and one
output}
\usage{
armaxsim
}
\description{
This dataset contains 2555 samples simulated from the following ARMAX model:
\deqn{
 y[k] = \frac{0.6q^{-2} - 0.2q^{-3}}{1 - 0.5q^{-1}} u[k] + 
 \frac{1-0.3q^{-1}}{1 - 0.5q^{-1}} e[k]
}
}
\details{
The model is simulated with a 2555 samples long full-band PRBS input.
The noise variance is set to 0.1
}
\keyword{datasets}

