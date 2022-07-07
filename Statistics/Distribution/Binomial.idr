module Statistics.Distribution.Binomial

import Statistics.Distribution.GSL

||| Sample from Binomial distribution
%foreign "C:gsl_ran_binomial, libgsl"
binomial_c : (seed : AnyPtr) -> (p : Double) -> (n : Int) -> PrimIO Int

export 
binomial : (n : Nat) -> (p : Double) -> GslRng -> IO Nat
binomial n p (MkGslRng seed) = primIO (binomial_c seed p (cast n)) >>= pure . cast

||| Compute PDF from Binomial distribution
%foreign "C:gsl_ran_binomial_pdf,libgsl"
binomial_pdf_c : (obs : Int) -> (p : Double) -> (n : Int) -> Double

export
binomial_pdf : (n : Nat) -> (p : Double) -> (obs : Nat) -> Double
binomial_pdf n p y = binomial_pdf_c (cast y) p (cast n)