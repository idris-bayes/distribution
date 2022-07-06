module Statistics.Distribution.Normal

import Data.So
import Statistics.Distribution.GSL
import Statistics.Distribution.Uniform
import System.FFI

{- GSL -}
||| Sample from Normal distribution
%foreign "C:gsl_ran_gaussian,libgsl"
normal_gsl_c : (seed : AnyPtr) -> (std : Double) -> Double

export
normal_gsl : (mu : Double) -> (std : Double) -> GslRng -> IO Double
normal_gsl mu std (MkGslRng seed) = pure $ mu + normal_gsl_c seed std

||| Compute PDF from Normal distribution
%foreign "C:gsl_ran_gaussian_pdf,libgsl"
normal_pdf_c : (obs_around_zero : Double) -> (std : Double) -> Double 

export
normal_pdf : (mu : Double) -> (std : Double) -> (obs : Double) -> Double
normal_pdf mu std y = normal_pdf_c (y - mu) std

||| Sample from Normal distribution using inverse CDF. It must hold that '0 < r < 1'.
%foreign "C:gsl_cdf_gaussian_Pinv,libgsl"
normal_cdf_inv_c : (r : Double) -> (std : Double) -> Double

export
normal_cdf_inv : (mu : Double) -> (std : Double) -> (r : Double) -> Double
normal_cdf_inv mu std r = mu + normal_cdf_inv_c r std

{- Custom -}
||| Box muller transform to sample from standard normal distribution of mean 0 and standard deviation 1.
box_muller : Double -> Double -> Double
box_muller u1 u2 = sqrt (-2 * log u1) * cos (2 * pi * u2)

||| Normal distribution with specified mean and std.
export
normal : (mean : Double) -> (std : Double)                --     -> {auto _ : (std > 0) === True}
      -> (r1 : Double) -> (r2 : Double)
      -> Double
normal mu std r1 r2 = mu + std * box_muller r1 r2
