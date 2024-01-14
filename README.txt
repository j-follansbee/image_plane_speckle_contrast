This repo contains code for calculating speckle contrast using integrals shown in the corresponding paper.

The section_1_method code uses the individual parameters to calculate speckle contrast (all in units of meters):
- f (focal length)
- wvl (wavelength)
- D (aperture size)
- d (detector size)

The appendix_method code uses only FLOD to calculate speckle contrast.

The check_calculations script runs both methods and plots the results to show that they are nearly identical.
There is a very small difference at extremely small FLOD values ~= 0.001, which do not correspond to realistic optical systems.

The function for each method also takes a parameter telling it how finely to sample the numerical grids.
I have found that 100 samples for the section 1 method and 1000 samples for the appendix method lead to good results.
