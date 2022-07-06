module Statistics.Distribution.Dirichlet

import Statistics.Distribution.GSL
import Statistics.Distribution.Gamma
import Data.Vect 

%foreign "C:gsl_ran_dirichlet_pdf,libgsl"
dirichlet_pdf_c : Int -> AnyPtr -> AnyPtr -> Double

export
dirichlet_pdf : {n : Nat} -> (alphas : Vect (S n) Double) -> (obs : Vect (S n) Double) -> Double
dirichlet_pdf alphas ys = 
  let alphas_ptr = build_array alphas
      ys_ptr     = build_array ys
  in dirichlet_pdf_c (cast $ S n) alphas_ptr ys_ptr

export
t : Double
t = dirichlet_pdf [0.1,0.3,0.6] [0.2,0.2,0.6]