K_s = 0:0.1:5;
K_s(1) = 0.01;

%% calculate using section 1 integral

contrasts_sec1 = zeros(size(K_s));

for i = 1:size(K_s,2)
    contrasts_sec1(i) = section_1_method(K_s(i), 1, 1, 1, 1000, 100);
end


%% calculate using appendix integral

contrasts_appendix = zeros(size(K_s));

for i = 1:size(K_s,2)
    contrasts_appendix(i) = appendix_method(K_s(i), 1000);
end

%% plot results

figure
clf
hold on
plot(K_s, contrasts_sec1, "LineWidth",3)
plot(K_s, contrasts_appendix, "--", "LineWidth",3)
xlabel("$F\lambda/d$", "Interpreter","latex")
ylabel("Speckle Contrast", "Interpreter","latex")
title("Speckle Contrast Integral from Appendix A", "Interpreter","latex")
legend(["Section 1 Integral", "Appendix Integral"], "Location", "southeast")
ylim([0, 1])
fontsize(gcf, "scale", 1.5)
