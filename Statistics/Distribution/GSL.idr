module Statistics.Distribution.GSL

import public Data.Vect

||| Container for a GSL RNG seed
public export
data GslRng : Type where
  MkGslRng : AnyPtr -> GslRng

||| Initialise a GSL RNG seed
%foreign "C:init_gsl_rng,distributions"
init_rng_c : AnyPtr

export
init_rng : GslRng
init_rng = MkGslRng init_rng_c

||| Initialise (alloc) an array of doubles of length 'n'
%foreign "C:init_array, distributions"
init_array_c : (n : Int) -> AnyPtr

export
init_array : (n : Nat) -> AnyPtr
init_array = init_array_c . cast

||| Set base_ptr[idx] to val, and return base_ptr
%foreign "C:assign_array, distributions"
assign_array_c : (base_ptr : AnyPtr) -> (idx : Int) -> (val : Double) -> AnyPtr

||| Print an n-sized array of doubles 
%foreign "C:print_array, distributions"
print_array_c : (base_ptr : AnyPtr) -> (n : Int) -> PrimIO ()

||| Get the double value at base_ptr[idx]
%foreign "C:index_array, distributions"
index_array_c : (base_ptr : AnyPtr) -> (idx : Int) -> Double 

export
rangeTo : (n : Nat) -> Vect n Nat
rangeTo Z = []
rangeTo (S n) = snoc (rangeTo n) (n)

||| Translate a vector to an array of doubles.
export
to_array : {n : Nat} -> Vect (S n) Double -> AnyPtr
to_array xs = 
  let ptr = init_array_c (cast (S n))
      f  : Vect (S n) AnyPtr = map (\(x, idx) => assign_array_c ptr (cast idx) x ) (zip xs (rangeTo (S n)))
  in  head f

||| Read an array of doubles to a vector.
export
from_array : {n : Nat} -> AnyPtr -> Vect (S n) Double
from_array ptr =
  map (\idx => index_array_c ptr (cast idx)) (rangeTo (S n))

export
testArray : IO ()
testArray = do
  let p = to_array [0, 1, 2, 3]
  primIO (print_array_c p 4)
