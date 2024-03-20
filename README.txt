This repo contains code for calculating speckle contrast using integrals shown in the corresponding paper.

The parameter_method code uses the individual parameters to calculate speckle contrast (all in units of meters):
- f (focal length)
- wvl (wavelength)
- D (aperture size)
- d (detector size)

The FLOD_method code uses only FLOD (F Lambda Over D) to calculate speckle contrast.

The check_calculations script runs both methods and plots the results to show that they are nearly identical.
The function for each method also takes a parameter telling it how finely to sample the numerical grids.