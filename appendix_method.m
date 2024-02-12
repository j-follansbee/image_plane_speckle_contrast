function [C] = appendix_method(K , n_samps)

% get sampled arrays for u and theta
samp1 = sqrt(2) * pi / K / n_samps;
samp2 = pi / 4 / n_samps;
u = 0 : samp1: pi/K * sqrt(2);
theta = 0 : samp2 : pi/4;
[u_s, thetas] = meshgrid(u, theta);

% prevent division by zero
u_s(:,1) = 1E-15;

% compute integrand
integrand1 = (besselj(1, u_s)).^2;
integrand2 = (pi./u_s./K) - sin(thetas) - cos(thetas) + (u_s*K.*sin(thetas).*cos(thetas)./pi);
integrand = integrand1.*integrand2;

% figure out what u-values should be masked out
mask = u_s < (pi*sec(thetas)/K);

% compute riemann sum and contrast
integral = sum(integrand.*mask, "all") * samp1 * samp2;
C = sqrt(32*(K/pi)^3 * integral);

end

