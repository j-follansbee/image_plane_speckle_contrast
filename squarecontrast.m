function [C] = squarecontrast(K)

    x = 2./K;
    C = (4./(x.^2)) .* (cosint(x) + cos(x) + x.*sinint(x) - log(x) - eulergamma - 1);
    C = double(C);

    mask = isnan(C);
    C(mask) = 0;
    
end