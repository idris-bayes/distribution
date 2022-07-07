module Statistics.Distribution.Normal

import Statistics.Distribution.GSL
import System.FFI

||| Sample from Normal distribution
%foreign "C:gsl_ran_gaussian,libgsl"
gsl_normal_c : (seed : AnyPtr) -> (std : Double) -> PrimIO Double

export
gsl_normal : (mu : Double) -> (std : Double) -> GslRng -> IO Double
gsl_normal mu std (MkGslRng seed) = primIO (gsl_normal_c seed std) >>= pure . (+ mu)

||| Compute PDF from Normal distribution
%foreign "C:gsl_ran_gaussian_pdf,libgsl"
gsl_normal_pdf_c : (obs_around_zero : Double) -> (std : Double) -> Double 

export
gsl_normal_pdf : (mu : Double) -> (std : Double) -> (obs : Double) -> Double
gsl_normal_pdf mu std y = gsl_normal_pdf_c (y - mu) std

||| Sample from Normal distribution using inverse CDF. It must hold that '0 < r < 1'.
%foreign "C:gsl_cdf_gaussian_Pinv,libgsl"
gsl_normal_cdf_inv_c : (r : Double) -> (std : Double) -> Double

export
gsl_normal_cdf_inv : (mu : Double) -> (std : Double) -> (r : Double) -> Double
gsl_normal_cdf_inv mu std r = mu + gsl_normal_cdf_inv_c r std