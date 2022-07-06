module Statistics.Distribution.Beta

import Statistics.Distribution.GSL
import Data.So

{- GSL -}
||| Sample from Beta distribution
%foreign "C:gsl_ran_beta,libgsl"
beta_gsl_c : (seed : AnyPtr) -> (a : Double) -> (b : Double) -> Double

export
beta_gsl : (a : Double) -> (b : Double) -> GslRng -> IO Double
beta_gsl a b (MkGslRng seed) = pure $ beta_gsl_c seed a b

||| Compute PDF from Beta distribution
%foreign "C:gsl_ran_beta_pdf,libgsl"
beta_pdf_c : (obs : Double) -> (a : Double) -> (b : Double) -> Double

export
beta_pdf : (a : Double) -> (b : Double) -> (obs : Double) -> Double
beta_pdf a b y = beta_pdf_c y a b

||| Sample from Beta distribution using inverse CDF. It must hold that '0 < r < 1'.
%foreign "C:gsl_cdf_beta_Pinv,libgsl"
beta_cdf_inv_c : (r : Double) -> (a : Double) -> (b : Double) -> Double

export
beta_cdf_inv : (a : Double) -> (b : Double) -> (r : Double) -> Double
beta_cdf_inv a b r = beta_cdf_inv_c r a b
