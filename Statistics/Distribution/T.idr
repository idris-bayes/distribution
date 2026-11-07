module Statistics.Distribution.T

import Statistics.Distribution.GSL

||| Sample from Student's t distribution with `nu` degrees of freedom
%foreign "C:gsl_ran_tdist,libgsl"
gsl_tdist_c : (seed : AnyPtr) -> (nu : Double) -> PrimIO Double

export
gsl_tdist : (nu : Double) -> GslRng -> IO Double
gsl_tdist nu (MkGslRng seed) = primIO $ gsl_tdist_c seed nu

||| Compute PDF from Student's t distribution
%foreign "C:gsl_ran_tdist_pdf,libgsl"
gsl_tdist_pdf_c : (obs : Double) -> (nu : Double) -> Double

export
gsl_tdist_pdf : (nu : Double) -> (obs : Double) -> Double
gsl_tdist_pdf nu y = gsl_tdist_pdf_c y nu

||| Sample from Student's t distribution using inverse CDF. It must hold that '0 < r < 1'.
%foreign "C:gsl_cdf_tdist_Pinv,libgsl"
gsl_tdist_cdf_inv_c : (r : Double) -> (nu : Double) -> Double

export
gsl_tdist_cdf_inv : (nu : Double) -> (r : Double) -> Double
gsl_tdist_cdf_inv nu r = gsl_tdist_cdf_inv_c r nu
