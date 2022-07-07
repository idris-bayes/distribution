module Statistics.Distribution.Normal

import Data.So
import Statistics.Distribution.GSL
import Statistics.Distribution.Uniform
import System.FFI

||| Sample from Normal distribution
%foreign "C:gsl_ran_gaussian,libgsl"
normal_c : (seed : AnyPtr) -> (std : Double) -> PrimIO Double

export
normal : (mu : Double) -> (std : Double) -> GslRng -> IO Double
normal mu std (MkGslRng seed) = primIO (normal_c seed std) >>= pure . (+ mu)

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