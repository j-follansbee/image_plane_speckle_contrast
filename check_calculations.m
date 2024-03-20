K_s = 0:0.2:5;
K_s(1) = 0.01;

%% calculate using integral with individual parameters

contrasts_sec1 = zeros(size(K_s));

for i = 1:size(K_s,2)
    % we set the first parameter to FLOD, and the remaining parameters to 1
    % for simplicity
    contrasts_sec1(i) = parameter_method(K_s(i), 1, 1, 1, 1000, 100);
end


%% calculate using FLOD integral

contrasts_appendix = zeros(size(K_s));

for i = 1:size(K_s,2)
    % calculate contrast using only FLOD
    contrasts_appendix(i) = FLOD_method(K_s(i), 1000);
end

%% plot results

figure
clf
hold on
plot(K_s, contrasts_sec1, "LineWidth",3)
plot(K_s, contrasts_appendix, "--", "LineWidth",3)
xlabel("$F\lambda/d$", "Interpreter","latex")
ylabel("Speckle Contrast", "Interpreter","latex")
title("Speckle Contrast", "Interpreter","latex")
legend(["Parameter Integral", "FLOD Integral"], "Location", "southeast")
ylim([0, 1])
fontsize(gcf, "scale", 1.5)
