module Statistics.Distribution.Binomial

import Statistics.Distribution.GSL

{- GSL -}
||| Sample from Binomial distribution
%foreign "C:gsl_ran_binomial, libgsl"
binomial_gsl_c : AnyPtr -> (p : Double) -> (n : Int) -> Int

export 
binomial_gsl : (n : Nat) -> (p : Double) -> GslRng -> Int
binomial_gsl n p (MkGslRng seed) = binomial_gsl_c seed p (cast n)

||| Compute PDF from Binomial distribution
%foreign "C:gsl_ran_binomial_pdf,libgsl"
binomial_pdf_c : (obs : Int) -> (p : Double) -> (n : Int) -> Double

export
binomial_pdf : (n : Nat) -> (p : Double) -> (obs : Nat) -> Double
binomial_pdf n p y = binomial_pdf_c (cast y) p (cast n)


{-
binomial : (n : Nat) -> (p : Double) -> IO Nat
binomial n p = do
         x <- replicateM n (uniform 0 1)
         pure . length . filter (< p) $ x
-}

{-
binomial_pdf'' : Int -> Double -> Int -> Double
binomial_pdf'' n p y = (binom n y) * (pow p y) * (pow (1 - p) (n - y))
  where factorial : (n : Int) -> Int
        factorial 0 = 1
        factorial n = n * factorial (n - 1)

        binom : (n, y : Int) -> Int
        binom n y = (factorial n) `div` ((factorial y) * factorial (n - y))
-}
