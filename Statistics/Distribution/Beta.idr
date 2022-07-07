module Statistics.Distribution.Beta

import Statistics.Distribution.GSL
import Data.So


||| Sample from Beta distribution
%foreign "C:gsl_ran_beta,libgsl"
gsl_beta_c : (seed : AnyPtr) -> (a : Double) -> (b : Double) -> PrimIO Double

export
gsl_beta : (a : Double) -> (b : Double) -> GslRng -> IO Double
gsl_beta a b (MkGslRng seed) = primIO $ gsl_beta_c seed a b

||| Compute PDF from Beta distribution
%foreign "C:gsl_ran_beta_pdf,libgsl"
gsl_beta_pdf_c : (obs : Double) -> (a : Double) -> (b : Double) -> Double

export
gsl_beta_pdf : (a : Double) -> (b : Double) -> (obs : Double) -> Double
gsl_beta_pdf a b y = gsl_beta_pdf_c y a b

||| Sample from Beta distribution using inverse CDF. It must hold that '0 < r < 1'.
%foreign "C:gsl_cdf_beta_Pinv,libgsl"
gsl_beta_cdf_inv_c : (r : Double) -> (a : Double) -> (b : Double) -> Double

export
gsl_beta_cdf_inv : (a : Double) -> (b : Double) -> (r : Double) -> Double
gsl_beta_cdf_inv a b r = gsl_beta_cdf_inv_c r a b
