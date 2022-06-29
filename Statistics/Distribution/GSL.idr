module Statistics.Distribution.GSL

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
