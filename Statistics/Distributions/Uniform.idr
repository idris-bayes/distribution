module Statistics.Distributions.Uniform

public export
uniform : Double -> Double -> Double -> Double
uniform min max x = x * (max - min) + min

public export
uniform_pdf : Double -> Double -> Double -> Double
uniform_pdf min max y with (y < max && y > min)
 _ | True = 1/(max - min)
 _ | _    = 0
