#include <stdio.h>
#include <math.h>
#include <gsl/gsl_rng.h>

double* init_array(int size) {
  double *array;
  array = malloc(size * sizeof (double));
  return array;
}

double* assign_array(double* ptr, int idx, double x) {
  ptr[idx] = x;
  return ptr;
}

double index_array(double* ptr, int idx) {
  return ptr[idx];
}

void* print_array(double* ptr, int size) {
  for(int i = 0; i < size; i ++){
    printf("%f ", ptr[i]);
  }
}

gsl_rng* init_gsl_rng() {
  gsl_rng* r;
  gsl_rng_env_setup();
  const gsl_rng_type * T;
  T = gsl_rng_default;
  r = gsl_rng_alloc (T);
  return r;    
}

// cc -shared -fPIC distributions.c -o distributions.so -lm -lgsl
