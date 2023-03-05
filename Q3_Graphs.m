%% Clear Workspace!
clear
clc
close all

%%% United States
s_US = [
41
52
90
107
107
159
184
254
341
400
369
423
416
750
928];
%%% France
s_FR = [
15
24
38
37
46
57
78
102
134
278
338
388]; 
%%% United Kingdom (See 1.6 for explanation)
s_UK = s_FR * 0.86;
t_US = 2008:2022;
t_FR = 2008:2019;
t_US = t_US';
t_FR = t_FR';
t_UK = t_FR;

%3 lbs of lead per bike, 10% of bikes use lead-acid batteries, 1% of
% lead-acid batteries not recycled. Multiply each regression line for sales
% by 3*0.01*0.01, in order to estimate many pounds of lead will be
% wasted annually due to electric bike sales

figure();
title("Estimated Pounds of Lead Wasted, in the US and UK", ...
'FontSize', 28);
xlabel("Year", "FontSize", 20);
ylabel("Pounds of Lead Wasted (thousands)", "FontSize", 20);
axis([2006,2030, 0,5])
years_after_start = 25;
x = 1:years_after_start;
x = x + 2006;
hold on
[~, p, ~, ~] = fit_logistic(t_US, s_US);
thalf = 2022;
Qinf = 2000;
alpha = 0.3;
Q_US = Qinf./(1 + exp(-alpha*(x-thalf)));
scatter(t_US, 0.01*0.3*s_US, 20, [0.902, 0.651, 0.149]);
plot(x, 0.01*0.3*Q_US, 'Color', [0.902, 0.651, 0.149]);
[~, p, ~, ~] = fit_logistic(t_UK, s_UK);
thalf = p(1);
Qinf = p(2);
alpha = p(3);
Q_UK = Qinf./(1 + exp(-alpha*(x-thalf)));
scatter(t_UK, 0.01*0.3*s_UK, 20, [0.094, 0.157, 0.976]);
plot(x, 0.01*0.3*Q_UK, 'Color', [0.094, 0.157, 0.976]);
legend("United States (Scatter)", "United States (Logistic Reg)", ...
"United Kingdom (Scatter)", "United Kingdom (Logistic Reg)", ...
"Location", "southoutside",'FontSize', 14)