require(copula)
require(ggplot2)
require(stringr)

n_steps = 1000000 # maximum running time
n_plot = 100000 # number of points shown in graph of X(t)
temp_steps = 100 # space between plotted points in occupation graph (useful when n_steps is large)

X <- vector("numeric",length = n_steps) # variable tracking position of the walk
Z <- vector("numeric",length = n_steps) # Occupation time (averaged over total time)
T <- vector("numeric",length = n_steps) # Vector to track total time 

###
# Setting initial values to 0, changing X[0] varies the starting position of the walk
###
X[0] <- 0
T[0] <- 0
Z[0] <- 0

###
# Initialising dummy variables used to track and fill in vectors above and track number of simulation steps
###
t <- 0 
y <- 0 
z <- 0 
n <- 0 

###
# Boundary values of the "slow area" A
###
A_left = 100
A_right = 105

###
# Parameter of the Sibuya rvs. alpha1 when in A and alpha2 outside of A
###
alpha1 <- 0.45
alpha2 <- 0.95

alpha <- function(r){
  
  if(x > A_right || x < A_left){
    return(alpha2)
  }
  else{
    return(alpha1)
  }
  
  
}

###
# Simulation of the walk
###

while (n < n_steps) {
  
  if(y >= A_left && y <= A_right){
    sib <- rSibuya(1,alpha1)
    z <- z + sib
  } else {
    sib <- rSibuya(1,alpha2)
  }
  t <- t + sib
  U <- runif(1)
  if (U < 0.5) {
    y <- y + 1 
    } else {
    y <- y - 1
    }
  X[n] <- y
  Z[n] <- z/t
  T[n] <- t
  
  if (n %% (n_steps/10) == 0){
  }
  n <- n + 1
}

###
# Plotting of results. Depending on variables it can take a long time to see convergence in occupation time.
# Increasing the value of temp_steps can allow one to increase simulation time while maintaining visual clarity.
###
  
  ggplot(NULL,aes(x = head(T, n_plot), y = head(X, n_plot))) + 
    geom_line() + 
    labs(x = "Time", y = "X(t)", title = str_glue("alpha1 = ", alpha1, ", alpha2 = ", alpha2, ". A = [", A_left, ", ", A_right, "]") ) +
    theme_minimal()
  
  
  ggplot(NULL,aes(x = T[seq_along(T)%%temp_steps == 0], y = Z[seq_along(Z)%%temp_steps == 0])) + 
    geom_line() + 
    labs(x = "Time", y = "Averaged Occupation time of A", title = str_glue("alpha1 = ", alpha1, ", alpha2 = ", alpha2, ". A = [", A_left, ", ", A_right, "]") )
