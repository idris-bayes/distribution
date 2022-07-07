module Statistics.Distribution.Gamma

import Data.So
import Statistics.Distribution.GSL

||| Sample from Gamma distribution
%foreign "C:gsl_ran_gamma,libgsl"
gsl_gamma_c : (seed : AnyPtr) -> (a : Double) -> (b : Double) -> PrimIO Double

export
gsl_gamma : (a : Double) -> (b : Double) -> GslRng -> IO Double
gsl_gamma a b (MkGslRng seed) = primIO $ gsl_gamma_c seed a b

||| Compute PDF from Gamma distribution
%foreign "C:gsl_ran_gamma_pdf,libgsl"
gsl_gamma_pdf_c : (obs : Double) -> (a : Double) -> (b : Double) -> Double

export
gsl_gamma_pdf : (a : Double) -> (b : Double) -> (obs : Double) -> Double
gsl_gamma_pdf a b y = gsl_gamma_pdf_c y a b

||| Sample from Gamma distribution using inverse CDF. It must hold that '0 < r < 1'.
%foreign "C:gsl_cdf_gamma_Pinv,libgsl"
gsl_gamma_cdf_inv_c : (r : Double) -> (a : Double) -> (b : Double) -> Double

export
gsl_gamma_cdf_inv : (a : Double) -> (b : Double) -> (r : Double) -> Double
gsl_gamma_cdf_inv a b r = gsl_gamma_cdf_inv_c r a b
