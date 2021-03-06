% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/idframe.R
\name{idframe}
\alias{idframe}
\title{S3 class for storing input-output data.}
\usage{
idframe(output, input = NULL, Ts = 1, start = 0, end = NULL,
  unit = c("seconds", "minutes", "hours", "days")[1])
}
\arguments{
\item{output}{dataframe/matrix/vector containing the outputs}

\item{input}{dataframe/matrix/vector containing the inputs}

\item{Ts}{sampling interval (Default: 1)}

\item{start}{Time of the first observation}

\item{end}{Time of the last observation Optional Argument}

\item{unit}{Time unit (Default: "seconds")}
}
\value{
an idframe object
}
\description{
\code{idframe} is an S3 class for storing and manipulating input-ouput data. It supports discrete time and frequency domain data.
}
\examples{

dataMatrix <- matrix(rnorm(1000),ncol=5) 
data <- idframe(output=dataMatrix[,3:5],input=dataMatrix[,1:2],Ts=1)

}
\seealso{
\code{\link{plot.idframe}}, the plot method for idframe objects
}

