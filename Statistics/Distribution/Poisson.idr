module Statistics.Distribution.Poisson

import Statistics.Distribution.GSL

{- GSL -}
||| Sample from Geometric distribution
%foreign "C:gsl_ran_poisson,libgsl"
poisson_c : (seed : AnyPtr) -> (mu : Double) -> PrimIO Int

export
poisson : (mu : Double) -> GslRng -> IO Nat
poisson mu (MkGslRng seed) = primIO (poisson_c seed mu) >>= pure . cast

||| Compute PDF from Geometric distribution
%foreign "C:gsl_ran_poisson_pdf,libgsl"
poisson_pdf_c : (obs : Int) -> (p : Double) -> Double

export
poisson_pdf : (p : Double) -> (obs : Nat) -> Double
poisson_pdf p y = poisson_pdf_c (cast y) p