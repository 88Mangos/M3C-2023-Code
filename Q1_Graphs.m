%% Clear Workspace!
clear
clc
close all

%%% Functions imported from outside places include:
% fit_logistic.m
% imported from:
% https://www.mathworks.com/matlabcentral/fileexchange/41781-fit_logistic-t-q

%% Data Input

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

%%% Europe
s_EU = [
98
173
279
422
588
716
854
907
1139
1364
1637
2074
2767
3397
4537
5057];

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
s_UK = s_FR * 1.16;

%%% China
s_CN = [
10000
14000
15500
20000
23000
27250
34500
36000
34400
31800
31400
30500
32200
36800
47600
41000
44150];

%%% India
s_IN = [
20
23
55
126
152
144
231];

%%% Japan
s_JP = [
300
300
280
300
300
409
392
446
474
468
540
616
666
698
738];

%%% Times for each country
t_US = 2008:2022;
t_EU = 2006:2021;
t_FR = 2008:2019;
t_CN = 2006:2022;
t_IN = 2016:2022;
t_JP = 2006:2020;

%%% Transposing the vectors in order to match up with the series data for
%%% annual sales
t_US = t_US';
t_EU = t_EU';
t_FR = t_FR';
t_CN = t_CN';
t_IN = t_IN';
t_JP = t_JP';
%%% Matching the UK data time period to France's
t_UK = t_FR;

%%% Defining which times we will be solving for worldwide sales (2 to 5
%%% years from today, in 2023).
t1 = 2025;
t2 = 2028;


%% Graph 1: The Major Players - Europe and China.
figure();
title("Sales of Electric Bicycles from 2006-2031, in Europe and China", ...
    'FontSize', 28);
xlabel("Year", 'FontSize', 20);
ylabel("Units of Electric Bicycles Sold (thousands)", 'FontSize', 20);
axis([2006,2030, 0,50000])

% Set the time period of interest
% Calculate data points using our regression up to 2031 (just a few years
% after 2028, which would be 5 years from today).
years_after_start = 25;
x = 1:years_after_start;
x = x + 2006;

hold on

%%% General Format for each country's plot
% 1. Generate the logistic regression equation using fit_logistic
% 2. Get thalf (time value of inflection point)
% 3. Qinf (the maximum theoretical annual sales, in thousands of units)
% 4. Get the alpha value (negative constant used in the logistic equation
% 5. Use the thalf, Qinf, and alpha values to compute the predicted sales
% in the time period set by x

% Europe
[~, p, ~, ~] = fit_logistic(t_EU, s_EU);
thalf = p(1)
Qinf = p(2)
alpha = p(3)
Q_EU = Qinf./(1 + exp(-alpha*(x-thalf)));
scatter(t_EU, s_EU, 20, "blue");
plot(x, Q_EU, 'Color', 'blue');

Q_EU1 = Qinf./(1 + exp(-alpha*(t1-thalf)));
Q_EU2 = Qinf./(1 + exp(-alpha*(t2-thalf)));

% China
[~, p, ~, ~] = fit_logistic(t_CN, s_CN);
thalf = p(1)
Qinf = p(2)
alpha = p(3)
Q_CN = Qinf./(1 + exp(-alpha*(x-thalf)));
scatter(t_CN, s_CN, 20, "red");
plot(x, Q_CN, 'Color', 'red');

% Compute the sales 2 and 5 years from today
Q_CN1 = Qinf./(1 + exp(-alpha*(t1-thalf)));
Q_CN2 = Qinf./(1 + exp(-alpha*(t2-thalf)));

% Add legend
legend("Europe (Scatter)", "Europe (Logistic Reg", ...
    "China (Scatter)", "China (Logistic Reg)", ...
    "Location", "southoutside",'FontSize', 14)
hold off

%% Graph 2: The Less Major Players - United States, France, India, Japan,
% and the United Kingdom.
figure();
title("Sales of Electric Bicycles from 2006-2031, in the US, France, " + ...
    "India, Japan, and the UK",'FontSize', 26)
xlabel("Year", 'FontSize', 20);
ylabel("Units of Electric Bicycles Sold (thousands)", 'FontSize', 20);
axis([2006,2030, 0,2000])

hold on

% US

%%% Note that the values for thalf, Qinf, and alpha have been manually
%%% tuned here. There was an issue we encountered, where the fit_logistic
%%% function would linearize and become really jerky, having ugly,
%%% undifferentiable corners. We used trial and error to adjust the curve
%%% to fit the data points.

%%% The solution to our issue was inspired by a discussion thread on 
% https://www.mathworks.com/matlabcentral/fileexchange/41781-fit_logistic-t-q
%%% by the creator of the fit_logistic function, James Conder, on 18 Feb
%%% 2020. We opted to not shift our data in order to preserve our data's
%%% accuracy, and instead just manually shift the points. We believe the
%%% issue came from the fit_logistic function calculating an extremely high
%%% alpha value.
[~, p, ~, ~] = fit_logistic(t_US, s_US);
%thalf = p(1);
thalf = 2022
%Qinf = p(2);
Qinf = 2000
%alpha = p(3);
alpha = 0.3
Q_US = Qinf./(1 + exp(-alpha*(x-thalf)));
scatter(t_US, s_US, 20, 'red');
plot(x, Q_US, 'Color', 'red');

% Compute the sales 2 and 5 years from today
Q_US1 = Qinf./(1 + exp(-alpha*(t1-thalf)));
Q_US2 = Qinf./(1 + exp(-alpha*(t2-thalf)));

% FR
[~, p, ~, ~] = fit_logistic(t_FR, s_FR);
thalf = p(1)
Qinf = p(2)
alpha = p(3)
Q_FR = Qinf./(1 + exp(-alpha*(x-thalf)));
scatter(t_FR, s_FR, 20, 'blue');
plot(x, Q_FR, 'Color', 'blue');

% Compute the sales 2 and 5 years from today
Q_FR1 = Qinf./(1 + exp(-alpha*(t1-thalf)));
Q_FR2 = Qinf./(1 + exp(-alpha*(t2-thalf)));

% IN
[~, p, ~, ~] = fit_logistic(t_IN, s_IN);
thalf = p(1)
Qinf = p(2)
alpha = p(3)
Q_IN = Qinf./(1 + exp(-alpha*(x-thalf)));
scatter(t_IN, s_IN, 20, 'green');
plot(x, Q_IN, 'Color', 'green');

% Compute the sales 2 and 5 years from today
Q_IN1 = Qinf./(1 + exp(-alpha*(t1-thalf)));
Q_IN2 = Qinf./(1 + exp(-alpha*(t2-thalf)));

% JP
[~, p, ~, ~] = fit_logistic(t_JP, s_JP);
thalf = p(1)
Qinf = p(2)
alpha = p(3)
Q_JP = Qinf./(1 + exp(-alpha*(x-thalf)));
scatter(t_JP, s_JP, 20, 'black');
plot(x, Q_JP, 'Color', 'black');

% Compute the sales 2 and 5 years from today
Q_JP1 = Qinf./(1 + exp(-alpha*(t1-thalf)));
Q_JP2 = Qinf./(1 + exp(-alpha*(t2-thalf)));

% UK
[~, p, ~, ~] = fit_logistic(t_UK, s_UK);
thalf = p(1)
Qinf = p(2)
alpha = p(3)
Q_UK = Qinf./(1 + exp(-alpha*(x-thalf)));
scatter(t_UK, s_UK, 20, 'cyan');
plot(x, Q_UK, 'Color', 'cyan');

% Compute the sales 2 and 5 years from today
Q_UK1 = Qinf./(1 + exp(-alpha*(t1-thalf)));
Q_UK2 = Qinf./(1 + exp(-alpha*(t2-thalf)));

% Add legend
legend("United States (Scatter)", "United States (Logistic Reg)", ...
    "France (Scatter)", "France (Logistic Reg)", ...
    "India (Scatter)", "India (Logistic Reg)",...
    "Japan (Scatter)", "Japan (Logistic Reg)", ...
    "United Kingdom (Scatter)", "United Kingdom (Logistic Reg)", ...
    "Location", "southoutside",'FontSize', 14)
hold off

% Compute the total predicted annual sales of electric bikes 2 to 5 years from today
Q_total1 = Q_UK1 + Q_JP1 + Q_IN1 + Q_FR1 + Q_US1 + Q_CN1 + Q_EU1
Q_total2 = Q_UK2 + Q_JP2 + Q_IN2 + Q_FR2 + Q_US2 + Q_CN2 + Q_EU2

%% Graph 3: US vs UK
figure();
title("Sales of Electric Bicycles from 2006-2031, in the US and the UK",'FontSize', 26)
xlabel("Year", 'FontSize', 20);
ylabel("Units of Electric Bicycles Sold (thousands)", 'FontSize', 20);
axis([2006,2030, 0,2000])

hold on

% US
[~, p, ~, ~] = fit_logistic(t_US, s_US);
%thalf = p(1);
thalf = 2022
%Qinf = p(2);
Qinf = 2000
%alpha = p(3);
alpha = 0.3
Q_US = Qinf./(1 + exp(-alpha*(x-thalf)));
scatter(t_US, s_US, 20, 'red');
plot(x, Q_US, 'Color', 'red');

% Compute the sales 2 and 5 years from today
Q_US1 = Qinf./(1 + exp(-alpha*(t1-thalf)));
Q_US2 = Qinf./(1 + exp(-alpha*(t2-thalf)));

% UK
[~, p, ~, ~] = fit_logistic(t_UK, s_UK);
thalf = p(1)
Qinf = p(2)
alpha = p(3)
Q_UK = Qinf./(1 + exp(-alpha*(x-thalf)));
scatter(t_UK, s_UK, 20, 'blue');
plot(x, Q_UK, 'Color', 'blue');

% Compute the sales 2 and 5 years from today
Q_UK1 = Qinf./(1 + exp(-alpha*(t1-thalf)));
Q_UK2 = Qinf./(1 + exp(-alpha*(t2-thalf)));

% Add legend
legend("United States (Scatter)", "United States (Logistic Reg)", ...
    "United Kingdom (Scatter)", "United Kingdom (Logistic Reg)", ...
    "Location", "southoutside",'FontSize', 14)
hold off
