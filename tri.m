function [output] = tri(x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

ab = 1 - abs(x);
logic = (abs(x)<1);
output = ab .* logic;


end