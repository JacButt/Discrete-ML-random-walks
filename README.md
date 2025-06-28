# Discrete-ML-random-walks
Simulation of discrete time semi-Markov random walks using discrete Mittag-Leffler and Sibuya random variables.

Currently contains simulation for a random walk with Sibuya distributed event times (which are a special case of the discrete Mittag-Leffler), with update to more general random walk settings in progress.

Code simulates a random walk starting from the origin that moves +1 or -1 with equal probability 1/2 at event times given by a sequence of Sibuya distributed random variables, simulated using Monte Carlo methods and the Copula package in R. The parameter of the Sibuya variables are allowed to vary based on the position of the walk, taking smaller values (and thus with longer inter-event times) in a set A. 

The trajectory of the random walk is tracked and plotted, as well as the Occupation time of the set A as a proportion of the cumulative time spent in the simulation. 

The motivation is to test for the appearance of an "anomolous aggregation" phenomena, where there is a critical ratio between the Sibuya parameters inside and outside of the set A such that the mean occupation time converges to 0 above this critical value, and converges to 1 below it.