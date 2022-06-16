module Statistics.Distribution.Normal

import Statistics.Distribution.Uniform
import System.FFI

||| Box muller transform to sample from standard normal distribution of mean 0 and standard deviation 1.
box_muller : Double -> Double -> Double
box_muller u1 u2 = sqrt (-2 * log u1) * cos (2 * pi * u2)

||| Normal distribution with specified mean and std.
export
normal : (mean : Double) -> (std : Double)                --     -> {auto _ : (std > 0) === True}
      -> (r1 : Double) -> (r2 : Double)
      -> Double
normal mu std r1 r2 = mu + std * box_muller r1 r2

export
%foreign "C:gsl_ran_gaussian_pdf,libgsl"
normal_pdf' : Double -> Double -> Double 

public export
normal_pdf : Double -> Double -> Double -> Double
normal_pdf mu std y = normal_pdf' (y - mu) std