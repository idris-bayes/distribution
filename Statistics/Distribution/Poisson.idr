module Statistics.Distribution.Poisson

import Statistics.Distribution.GSL

{- GSL -}
||| Sample from Geometric distribution
%foreign "C:gsl_ran_poisson,libgsl"
poisson_gsl_c : AnyPtr -> (mu : Double) -> Int

export
poisson_gsl : (mu : Double) -> GslRng -> Nat
poisson_gsl mu (MkGslRng seed) = cast (poisson_gsl_c seed mu)

||| Compute PDF from Geometric distribution
%foreign "C:gsl_ran_poisson_pdf,libgsl"
poisson_pdf_c : (obs : Int) -> (p : Double) -> Double

export
poisson_pdf : (p : Double) -> (obs : Nat) -> Double
poisson_pdf p y = poisson_pdf_c (cast y) p