module Statistics.Distribution

import public Statistics.Distribution.GSL
import public Statistics.Distribution.Beta
import public Statistics.Distribution.Binomial
import public Statistics.Distribution.Dirichlet
import public Statistics.Distribution.Gamma
import public Statistics.Distribution.Geometric
import public Statistics.Distribution.Normal
import public Statistics.Distribution.Poisson
import public Statistics.Distribution.Uniform

{- Testing
test : IO () -- (Double, Nat, Double, Vect 3 Double)
test = do
  let seed = init_rng
  n <- normal 17 0.5 seed
  b <- binomial 17 0.5 seed
  u <- uniform 0.5 17 seed
  d <- dirichlet [0.2, 0.3, 0.5] seed
  print d
-}