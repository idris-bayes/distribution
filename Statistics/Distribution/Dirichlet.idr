module Statistics.Distribution.Dirichlet

import Statistics.Distribution.GSL
import Statistics.Distribution.Gamma
import Data.Vect 

||| Sample from Dirichlet distribution
%foreign "C:gsl_ran_dirichlet,libgsl"
dirichlet_gsl_c : (seed : AnyPtr) -> (size : Int) -> (alphas : AnyPtr) -> (output : AnyPtr) -> PrimIO ()

export
dirichlet_gsl : HasIO io => {n : Nat} -> (alphas : Vect (S n) Double) -> GslRng -> io (Vect (S n) Double)
dirichlet_gsl alphas (MkGslRng seed) = do
  let alphas_ptr = to_array alphas
      output_ptr = init_array (S n) 
  primIO $ dirichlet_gsl_c seed (cast $ S n) alphas_ptr output_ptr
  pure (from_array output_ptr)

||| Compute PDF from Dirichlet distribution
%foreign "C:gsl_ran_dirichlet_pdf,libgsl"
dirichlet_pdf_c : Int -> AnyPtr -> AnyPtr -> Double

export
dirichlet_pdf : {n : Nat} -> (alphas : Vect (S n) Double) -> (obs : Vect (S n) Double) -> Double
dirichlet_pdf alphas ys = 
  let alphas_ptr = to_array alphas
      ys_ptr     = to_array ys
  in dirichlet_pdf_c (cast $ S n) alphas_ptr ys_ptr

export
t : Double
t = dirichlet_pdf [0.1,0.3,0.6] [0.2,0.2,0.6]