module Statistics.Distribution.Uniform

import Statistics.Distribution.GSL

{- GSL -}
%foreign "C:gsl_ran_flat, libgsl"
uniform_gsl_c : AnyPtr -> Double -> Double -> Double

public export
uniform_gsl : Double -> Double -> GslRng -> Double
uniform_gsl min max (MkGslRng seed) = uniform_gsl_c seed min max

public export
uniform_pdf : Double -> Double -> Double -> Double
uniform_pdf min max y with (y < max && y > min)
 _ | True = 1/(max - min)
 _ | _    = 0


{- Custom -}
public export
uniform : Double -> Double -> Double -> Double
uniform min max x = x * (max - min) + min