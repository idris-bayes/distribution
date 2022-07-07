module Statistics.Distribution.Poisson

import Statistics.Distribution.GSL

||| Sample from Geometric distribution
%foreign "C:gsl_ran_poisson,libgsl"
gsl_poisson_c : (seed : AnyPtr) -> (mu : Double) -> PrimIO Int

export
gsl_poisson : (mu : Double) -> GslRng -> IO Nat
gsl_poisson mu (MkGslRng seed) = primIO (gsl_poisson_c seed mu) >>= pure . cast

||| Compute PDF from Geometric distribution
%foreign "C:gsl_ran_poisson_pdf,libgsl"
gsl_poisson_pdf_c : (obs : Int) -> (p : Double) -> Double

export
gsl_poisson_pdf : (p : Double) -> (obs : Nat) -> Double
gsl_poisson_pdf p y = gsl_poisson_pdf_c (cast y) p