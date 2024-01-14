function [contrast] = section_1_method(f, wvl, D_ap, d, Dz, n_samps)
%ANALYTICAL_SPECKLE_CONTRAST Summary of this function goes here
%   Detailed explanation goes here

    z_im = ((-1/Dz) + (1/f))^(-1);     % [m] image distance

    flambdaoverd = f * wvl / D_ap / d;
    
    gridsamp = 1/n_samps;
    bound = 2;
    
    % analyze analytical speckle contrasts
    [xx, yy] = meshgrid(-bound:gridsamp:bound);
    xx = xx*d;
    yy = yy*d;

    % detector shape autocorrelation
    R_s = tri(xx / d) .* tri(yy / d) * d * d;
    
    r = (xx.^2 + yy.^2).^(1/2);
    piDlz = pi * D_ap / wvl / z_im;
    r(ceil(end/2), ceil(end/2)) = 1E-15;
    
    mu_a_sq = abs(2 * besselj(1, piDlz.*r) ./ (piDlz.*r) ).^2;
    
    M_integrand = mu_a_sq .* R_s;
    M_integral = sum(M_integrand, "all") * (d * gridsamp)^2;
    S = d*d;
    M = (M_integral / (S)^2 )^(-1);

    contrast= M^(-1/2);


end