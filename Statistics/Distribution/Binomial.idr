module Statistics.Distribution.Binomial

import Statistics.Distribution.GSL

||| Sample from Binomial distribution
%foreign "C:gsl_ran_binomial, libgsl"
gsl_binomial_c : (seed : AnyPtr) -> (p : Double) -> (n : Int) -> PrimIO Int

export 
gsl_binomial : (n : Nat) -> (p : Double) -> GslRng -> IO Nat
gsl_binomial n p (MkGslRng seed) = primIO (gsl_binomial_c seed p (cast n)) >>= pure . cast

||| Compute PDF from Binomial distribution
%foreign "C:gsl_ran_binomial_pdf,libgsl"
gsl_binomial_pdf_c : (obs : Int) -> (p : Double) -> (n : Int) -> Double

export
gsl_binomial_pdf : (n : Nat) -> (p : Double) -> (obs : Nat) -> Double
gsl_binomial_pdf n p y = gsl_binomial_pdf_c (cast y) p (cast n)