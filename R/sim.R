#' Simulate response of dynamic system
#' 
#' Simulate the response of a system to a given input
#' 
#' @param model the linear system to simulate
#' @param input a vector/matrix containing the input
#' @param addNoise logical variable indicating whether to add noise to the 
#' response model. (Default: \code{FALSE})
#' @param innov an optional times series of innovations. If not supplied (specified
#' as \code{NULL}), gaussian white noise is generated, with the variance specified in 
#' the model (Property: \code{noiseVar})
#' @param seed integer indicating the seed value of the random number generator.
#' Useful for reproducibility purposes.
#' 
#' @return
#' a vector containing the simulated output
#' 
#' @details
#' The routine is currently built only for SISO systems. Future versions will
#' include support for MIMO systems.
#' 
#' @examples
#' # ARX Model
#' u <- idinput(300,"rgs")
#' model <- idpoly(A=c(1,-1.5,0.7),B=c(0.8,-0.25),ioDelay=1,
#' noiseVar=0.1)
#' y <- sim(model,u,addNoise=TRUE)
#' 
#' @export
sim <- function(model,input,addNoise = F,innov=NULL,seed=NULL) UseMethod("sim")

#' @export
sim.default <- function(model,input,addNoise = F,innov=NULL,seed=NULL){
  print("The sim method is not developed for the current class of the object")
}

#' @import signal polynom
#' @export
sim.idpoly <- function(model,input,addNoise = F,innov=NULL,seed=NULL){
  B <- c(rep(0,model$ioDelay),model$B)
  Gden <- as.numeric(polynomial(model$A)*polynomial(model$F1))
  G <- signal::Arma(b=B,a=Gden)
  ufk <- signal::filter(G,input)
  yk <- as.numeric(ufk)
  
  if(addNoise){
    n <- ifelse(is.numeric(input),length(input),dim(input)[1])
    if(!is.null(innov)){
      ek <- innov
    } else{
      if(!is.null(seed)) set.seed(seed)
      ek <- rnorm(n,sd=sqrt(model$noiseVar))
    }
    den1 <- as.numeric(polynomial(model$A)*polynomial(model$D))
    filt1 <- Arma(b=model$C,a=den1)
    vk <- signal::filter(filt1,ek)
    
    yk <- yk + as.numeric(vk)
  }
  
  return(yk) 
}

# sim_arx <- function(model,input,ek){
#   na <- length(model$A) - 1; nk <- model$ioDelay; 
#   nb <- length(model$B) - 1; nb1 <- nb+nk
#   n <- max(na,nb1)
#   coef <- matrix(c(model$A[-1],model$B),nrow=na+(nb+1))
#   
#   if(class(input)=="idframe"){
#     uk <- input$input[,1,drop=T]
#   } else if(class(input) %in% c("matrix","data.frame")){
#     uk <- input[,1,drop=T]
#   } else if(is.numeric(input)){
#     uk <- input
#   }
#   
#   y <- rep(0,length(input)+n)
#   u <- c(rep(0,n),uk)
#   
#   for(i in n+1:length(uk)){
#     if(nk==0) v <- u[i-0:nb] else v <- u[i-nk:nb1]
#     reg <- matrix(c(-(y[i-1:na]),v),ncol=na+(nb+1))
#     y[i] <- reg%*%coef + ek[i]
#   }
#   return(y[n+1:length(uk)])
# }