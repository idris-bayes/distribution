module Statistics.Distribution.Test

import Statistics.Distribution.GSL
import Statistics.Distribution.Normal
import Statistics.Distribution.Binomial
import Statistics.Distribution.Uniform
import Statistics.Distribution.Dirichlet

public export
test : IO () -- (Double, Nat, Double, Vect 3 Double)
test = do
  let seed = init_rng
  n <- normal_gsl 17 0.5 seed
  b <- binomial_gsl 17 0.5 seed
  u <- uniform_gsl 0.5 17 seed
  d <- dirichlet_gsl [0.2, 0.3, 0.5] seed
  print d