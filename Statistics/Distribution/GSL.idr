module Statistics.Distribution.GSL

public export
data GslRng : Type where
  MkGslRng : AnyPtr -> GslRng

%foreign "C:init_gsl_rng,my_gsl_lib"
init_rng_c : AnyPtr

export
init_rng : GslRng
init_rng = MkGslRng init_rng_c
