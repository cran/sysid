% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rarx.R
\name{rarx}
\alias{rarx}
\title{Estimate parameters of ARX recursively}
\usage{
rarx(x, order = c(1, 1, 1), lambda = 0.95)
}
\arguments{
\item{x}{an object of class \code{idframe}}

\item{order}{Specification of the orders: the three integer components 
(na,nb,nk) are the order of polynolnomial A, (order of polynomial B + 1) and 
the input-output delay}

\item{lambda}{Forgetting factor(Default=\code{0.95})}
}
\value{
A list containing the following objects
\describe{
 \item{theta}{Estimated parameters of the model. The \eqn{k^{th}} 
 row contains the parameters associated with the \eqn{k^{th}} 
 sample. Each row in \code{theta} has the following format: \cr
 theta[i,:]=[a1,a2,...,ana,b1,...bnb]
 }
 \item{yhat}{Predicted value of the output, according to the 
 current model - parameters based on all past data}
}
}
\description{
Estimates the parameters of a single-output ARX model of the 
specified order from data using the recursive weighted least-squares
algorithm.
}
\examples{
Gp1 <- idpoly(c(1,-0.9,0.2),2,ioDelay=2,noiseVar = 0.1)
Gp2 <- idpoly(c(1,-1.2,0.35),2.5,ioDelay=2,noiseVar = 0.1)
uk = idinput(2044,'prbs',c(0,1/4)); N = length(uk);
N1 = round(0.35*N); N2 = round(0.4*N); N3 = N-N1-N2;
yk1 <- sim(Gp1,uk[1:N1],addNoise = TRUE)
yk2 <- sim(Gp2,uk[N1+1:N2],addNoise = TRUE)
yk3 <- sim(Gp1,uk[N1+N2+1:N3],addNoise = TRUE)
yk <- c(yk1,yk2,yk3)
z <- idframe(yk,uk,1)
g(theta,yhat) \%=\% rarx(z,c(2,1,2))

}
\references{
Arun K. Tangirala (2015), \emph{Principles of System Identification: 
Theory and Practice}, CRC Press, Boca Raton. Section 25.1.3

Lennart Ljung (1999), \emph{System Identification: Theory for the User}, 
2nd Edition, Prentice Hall, New York. Section 11.2
}

