module Statistics.Distribution.Uniform

import Data.So
import Statistics.Distribution.GSL
import System.Random

||| Sample from Uniform distribution
%foreign "C:gsl_ran_flat, libgsl"
gsl_uniform_c : (seed : AnyPtr) -> (min : Double) -> (max : Double) -> Double

public export
gsl_uniform :(min : Double) -> (max : Double) -> GslRng -> IO Double
gsl_uniform min max (MkGslRng seed) = pure $ gsl_uniform_c seed min max

||| Compute PDF from Uniform distribution
public export
gsl_uniform_pdf : (min : Double) -> (max : Double) -> (obs : Double) -> Double
gsl_uniform_pdf min max y with (y < max && y > min)
 _ | True = 1/(max - min)
 _ | _    = 0

||| Sample from Uniform distribution using inverse CDF. It must hold that '0 < r < 1'.
%foreign "C:gsl_cdf_flat_Pinv, libgsl"
gsl_uniform_cdf_inv_c : (r : Double) -> (min : Double) -> (max : Double) -> Double

public export
gsl_uniform_cdf_inv : (min : Double) -> (max : Double) -> (r : Double) -> Double
gsl_uniform_cdf_inv min max r = gsl_uniform_cdf_inv_c r min max 