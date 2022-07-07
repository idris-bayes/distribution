module Statistics.Distribution.Geometric

import Statistics.Distribution.GSL

||| Sample from Geometric distribution
%foreign "C:gsl_ran_geometric,libgsl"
gsl_geometric_c : (seed : AnyPtr) -> (p : Double) -> PrimIO Int

export
gsl_geometric : (p : Double) -> GslRng -> IO Nat
gsl_geometric p (MkGslRng seed) = primIO (gsl_geometric_c seed p) >>= pure . cast

||| Compute PDF from Geometric distribution
%foreign "C:gsl_ran_geometric_pdf,libgsl"
gsl_geometric_pdf_c : (obs : Int) -> (p : Double) -> Double

export
gsl_geometric_pdf : (p : Double) -> (obs : Nat) -> Double
gsl_geometric_pdf p y = gsl_geometric_pdf_c (cast y) p