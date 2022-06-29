module Statistics.Distribution.Geometric

import Statistics.Distribution.GSL

{- GSL -}
||| Sample from Geometric distribution
%foreign "C:gsl_ran_geometric,libgsl"
geometric_gsl_c : AnyPtr -> (p : Double) -> Int

export
geometric_gsl : (p : Double) -> GslRng -> Nat
geometric_gsl p (MkGslRng seed) = cast (geometric_gsl_c seed p)

||| Compute PDF from Geometric distribution
%foreign "C:gsl_ran_geometric_pdf,libgsl"
geometric_pdf_c : (obs : Int) -> (p : Double) -> Double

export
geometric_pdf : (p : Double) -> (obs : Nat) -> Double
geometric_pdf p y = geometric_pdf_c (cast y) p