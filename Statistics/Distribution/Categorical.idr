module Statistics.Distribution.Categorical

import Data.Buffer
import Data.Fin
import Data.Vect
import Statistics.Distribution.GSL

||| Preprocess weights into a lookup table, see `gsl_categorical_table`
%foreign "C:gsl_ran_discrete_preproc, libgsl"
gsl_ran_discrete_preproc_c : (k : Int) -> (weights : Buffer) -> PrimIO AnyPtr

%foreign "C:gsl_ran_discrete_free, libgsl"
gsl_ran_discrete_free_c : (table : AnyPtr) -> PrimIO ()

||| Sample from Categorical distribution
%foreign "C:gsl_ran_discrete, libgsl"
gsl_ran_discrete_c : (seed : AnyPtr) -> (table : GCAnyPtr) -> PrimIO Int

||| Compute PDF from Categorical distribution
%foreign "C:gsl_ran_discrete_pdf, libgsl"
gsl_ran_discrete_pdf_c : (k : Int) -> (table : GCAnyPtr) -> Double

||| Preprocessed table for drawing one of `k` outcomes, freed when garbage collected
export
data Categorical : (k : Nat) -> Type where
  MkCategorical : GCAnyPtr -> Categorical k

||| Build the table from weights, which don't need to sum to 1. It is a fatal error if a
||| weight is negative or all weights are zero.
export
categorical : {k : _} -> Vect (S k) Double -> IO (Categorical (S k))
categorical weights = do
  when (any (< 0) weights || sum weights <= 0) $
    assert_total $ idris_crash "categorical weights must be non-negative and not all zero"
  Just buffer <- newBuffer (cast (S k) * 8)
    | Nothing => assert_total $ idris_crash "categorical: allocation failed"
  fill buffer 0 weights
  table <- primIO $ gsl_ran_discrete_preproc_c (cast (S k)) buffer
  when (prim__nullAnyPtr table /= 0) $
    assert_total $ idris_crash "categorical: gsl_ran_discrete_preproc failed"
  map MkCategorical $ onCollectAny table (primIO . gsl_ran_discrete_free_c)
  where
    fill : Buffer -> Int -> Vect n Double -> IO ()
    fill _      _ []        = pure ()
    fill buffer i (w :: ws) = do
      setDouble buffer (i * 8) w
      fill buffer (i + 1) ws

||| Sample the position of one outcome from Categorical distribution
export
gsl_categorical : {k : _} -> Categorical k -> GslRng -> IO (Fin k)
gsl_categorical (MkCategorical table) (MkGslRng seed) = do
  i <- primIO $ gsl_ran_discrete_c seed table
  case natToFin (cast i) k of
    Just position => pure position
    Nothing       => assert_total $ idris_crash "categorical: draw out of range"

||| Compute PDF from Categorical distribution
export
gsl_categorical_pdf : Categorical k -> Fin k -> Double
gsl_categorical_pdf (MkCategorical table) i = gsl_ran_discrete_pdf_c (cast (finToNat i)) table
