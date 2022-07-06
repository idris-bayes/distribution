module Statistics.Distribution.Gamma

import Data.So
import Statistics.Distribution.GSL

{- GSL -}
||| Sample from Gamma distribution
%foreign "C:gsl_ran_gamma,libgsl"
gamma_gsl_c : (seed : AnyPtr) -> (a : Double) -> (b : Double) -> Double

export
gamma_gsl : (a : Double) -> (b : Double) -> GslRng -> IO Double
gamma_gsl a b (MkGslRng seed) = pure $ gamma_gsl_c seed a b

||| Compute PDF from Gamma distribution
%foreign "C:gsl_ran_gamma_pdf,libgsl"
gamma_pdf_c : (obs : Double) -> (a : Double) -> (b : Double) -> Double

export
gamma_pdf : (a : Double) -> (b : Double) -> (obs : Double) -> Double
gamma_pdf a b y = gamma_pdf_c y a b

||| Sample from Gamma distribution using inverse CDF. It must hold that '0 < r < 1'.
%foreign "C:gsl_cdf_gamma_Pinv,libgsl"
gamma_cdf_inv_c : (r : Double) -> (a : Double) -> (b : Double) -> Double

export
gamma_cdf_inv : (a : Double) -> (b : Double) -> (r : Double) -> Double
gamma_cdf_inv a b r = gamma_cdf_inv_c r a b
