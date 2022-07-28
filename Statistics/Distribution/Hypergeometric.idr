module Statistics.Distribution.Hypergeometric

import Statistics.Distribution.GSL

||| Sample from Hypergeometric distribution
%foreign "C:gsl_ran_hypergeometric,libgsl"
gsl_hypergeometric_c : (seed : AnyPtr) -> (n1 : Int) -> (n2 : Int) -> (t : Int) -> PrimIO Int

export
gsl_hypergeometric : (n1 : Nat) -> (n2 : Nat) -> (t : Nat) -> GslRng -> IO Nat
gsl_hypergeometric n1 n2 t (MkGslRng seed) = primIO (gsl_hypergeometric_c seed (cast n1) (cast n2) (cast t)) >>= pure . cast

||| Compute PDF from Hypergeometric distribution
%foreign "C:gsl_ran_hypergeometric_pdf,libgsl"
gsl_hypergeometric_pdf_c : (k : Int) -> (n1 : Int) -> (n2 : Int) -> (t : Int) -> Double

export
gsl_hypergeometric_pdf : (k : Nat) -> (n1 : Nat) -> (n2 : Nat) -> (t : Nat) -> Double
gsl_hypergeometric_pdf k n1 n2 t = gsl_hypergeometric_pdf_c (cast k) (cast n1) (cast n2) (cast t)