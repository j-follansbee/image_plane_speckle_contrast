clear

maxx = 10;
K_s = 0:0.1:maxx;

for i = 1:size(K_s,2)
    % calculate contrast using only FLOD
    C_s(i) = FLOD_method(K_s(i), 1500);
end

clear i

tempC = squarecontrast(K_s);

% fit square contrast curve
sqft = fittype("squarecontrast(a*x)", dependent="y", independent="x", coefficients=["a"]);
options = fitoptions('Method', 'NonlinearLeastSquares', ...
                     'Lower',[0], 'Upper',[1]);

sqpotential = fit(K_s', C_s', sqft, options);
sqfitvals = sqpotential(K_s) ;

%tablecurvefit = (1 - exp(-5/4 .* K_s));

%%

% fit exponential curve
expft = fittype("a*(1-exp(b*x))", dependent="y", independent="x", coefficients=["a", "b"]);
options = fitoptions('Method', 'NonlinearLeastSquares', ...
                     'Lower',[0.1, -20], 'Upper',[2, 20]);
exppotential = fit(K_s', C_s', expft, options);
expfitvals = exppotential(K_s);


%%
figure(1)
clf

subplot(1, 2, 1)
hold on
plot(K_s, C_s, "LineWidth",3)
plot(K_s, sqfitvals, "--", "LineWidth",3)
plot(K_s, expfitvals, "-.", "LineWidth",3)
xlim([0, maxx])

title("Speckle Contrast vs. $F\lambda /d$", "Interpreter","latex")
ylabel("Contrast", "Interpreter","latex")
xlabel("$F\lambda /d$", "Interpreter","latex")
grid off
ylim([0, 1])
legend(["Analytical Integral", "Square Integral Fit", "Exp Fit"], "Location","southeast")

% ax2 = axes("Position",[0.25, 0.4, 0.2, 0.2]);
% hold on
% plot(ax2, K_s, C_s, "LineWidth",3)
% plot(ax2, K_s, sqfitvals, "--", "LineWidth",3)
% plot(ax2, K_s, expfitvals, "-.", "LineWidth",3)
% xlim([0.5, 1.5])
% %ax2.XTickLabel = [];
% %ax2.YTickLabel = [];
% ylim([0.55, 0.7])
% xlim([0.65, 1])

%set(gca, "YScale", "log")
%ylim([0.4, 1])


subplot(1, 2, 2)
hold on
plot(K_s, 100*abs(sqfitvals' - C_s)./C_s, "LineWidth", 3);
plot(K_s, 100*abs(expfitvals' - C_s)./C_s, "LineWidth", 3);
title("\% Error", "Interpreter","latex")
xlabel("$F\lambda /d$", "Interpreter","latex")
ylabel("\% Error", "Interpreter","latex")
legend(["Square Integral Error", "Exp Error"], "Location","northeast")
grid off

%set(gca, "YScale", "log")
xlim([0, maxx])


set(gcf, "Position", [0, 0, 1000, 600])

fontsize(scale=2)