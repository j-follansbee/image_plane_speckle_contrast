function [contrast] = parameter_method(f, wvl, D_ap, d, Dz, n_samps)

z_im = ((-1/Dz) + (1/f))^(-1);  % [m] image distance
gridsamp = 1/n_samps;           % [unitless] pixel spacing
bound = 2;                      % [unitless] upper and lower bound for the x and y axes
[xx, yy] = meshgrid(-bound:gridsamp:bound); % create x, y meshgrids


% Set our x and y grids to cover +-2d, so we cover the entire region where
% R_s is nonzero (+-d) and an additional region where R_s is zero
xx = xx*d;
yy = yy*d;

% Compute detector shape autocorrelation gamma_s
gamma_s = tri(xx / d) .* tri(yy / d) * d * d;

% Convert x, y grids to radius for mu_a_squared term 
r = (xx.^2 + yy.^2).^(1/2);
piDlz = pi * D_ap / wvl / z_im;
r(ceil(end/2), ceil(end/2)) = 1E-15;

% Compute mu_a_squared
mu_a_sq = abs(2 * besselj(1, piDlz.*r) ./ (piDlz.*r) ).^2;

% Compute a Riemann sum of the integrand
integrand = mu_a_sq .* gamma_s;
integral = sum(integrand, "all") * (d * gridsamp)^2;

% Compute and return the contrast.
contrast = sqrt(integral/d^4);



end