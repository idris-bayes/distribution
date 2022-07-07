module Statistics.Distribution.Dirichlet

import Statistics.Distribution.GSL
import Statistics.Distribution.Gamma
import Data.Vect 

||| Sample from Dirichlet distribution
%foreign "C:gsl_ran_dirichlet,libgsl"
gsl_dirichlet_c : (seed : AnyPtr) -> (size : Int) -> (alphas : AnyPtr) -> (output : AnyPtr) -> PrimIO ()

export
gsl_dirichlet : {n : Nat} -> (alphas : Vect (S n) Double) -> GslRng -> IO (Vect (S n) Double)
gsl_dirichlet alphas (MkGslRng seed) = do
  let alphas_ptr = to_array alphas
      output_ptr = init_array (S n) 
  primIO $ gsl_dirichlet_c seed (cast $ S n) alphas_ptr output_ptr
  pure (from_array output_ptr)

||| Compute PDF from Dirichlet distribution
%foreign "C:gsl_ran_dirichlet_pdf,libgsl"
gsl_dirichlet_pdf_c : (size : Int) -> (alphas : AnyPtr) -> (obs : AnyPtr) -> Double

export
gsl_dirichlet_pdf : {n : Nat} -> (alphas : Vect (S n) Double) -> (obs : Vect (S n) Double) -> Double
gsl_dirichlet_pdf alphas ys = 
  let alphas_ptr = to_array alphas
      ys_ptr     = to_array ys
  in gsl_dirichlet_pdf_c (cast $ S n) alphas_ptr ys_ptr