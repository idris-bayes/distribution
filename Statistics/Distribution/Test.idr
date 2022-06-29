module Statistics.Distribution.Test

import Statistics.Distribution.GSL
import Statistics.Distribution.Normal
import Statistics.Distribution.Binomial
import Statistics.Distribution.Uniform

public export
test : (Double, Nat, Double)
test = let seed = init_rng
       in  (normal_gsl 17 0.5 seed, binomial_gsl 17 0.5 seed, uniform_gsl 0.5 17 seed)