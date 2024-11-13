clear

set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');

% Spring constants
syms K_t K_e 

% Distances
syms b_2 L_1 L_2 u_in
% body_2 Length_1 length_2
syms u_in0

% Angles
syms theta_1 theta_2
syms theta_10 theta_20

% Spring properties
syms E_t E_e I_t I_e l_t l_e

% Input force
syms F_in

% Calculate effective lengths and spring constants
L_2 = b_2 + l_t;
K_t = E_t * I_t / l_t;

% Linear spring has no change in effective length as it is mounted slightly
% offcenter due to needing to be attached to a body.

eq1 = u_in == 2*L_2*(1-cos(theta_2))
theta_2_sol = solve(eq1, theta_2);
theta_2_sol = theta_2_sol(1)

d_theta_2 = diff(theta_2_sol, u_in)

% Introduce Lagrange coordinates
phi_2 = theta_2_sol-theta_20
phi_3 = L_2*(sin(theta_2_sol)-sin(theta_20))

dphi_2 = diff(phi_2, u_in)
dphi_3 = diff(phi_3, u_in)

T_t = -4*K_t*phi_2
T_e = -K_e*phi_3

eq2 = F_in + T_t*dphi_2 + T_e*dphi_3

F_in_sol = solve(eq2, F_in)


% Flexure elements properties
E_flexure = 179e9;
b = 10e-3;
h = 0.4e-3;
I_value = b * h^3 / 12;

% Parameter dictionary
p_vars = [theta_20, l_t,  I_t,     E_t,       b_2,  K_e];
p_vals = [0,        10e-3, I_value, E_flexure, 0.1];
p_vals0 = [p_vals, 0];
p_vals1 = [p_vals, 1000];


F_in_sol_no_spring = subs(F_in_sol, p_vars, p_vals0);
F_in_sol_spring = subs(F_in_sol, p_vars, p_vals1);
theta_2_sol = subs(theta_2_sol, p_vars, p_vals0);

xmax = 0.3;
figure(1), clf;
tiledlayout(2,1)
nexttile;
hold on;
grid on;
fplot(6*F_in_sol_no_spring, [0, xmax])
% fplot(6*F_in_sol_spring, [0, xmax])
ylabel("$F$ Force")
nexttile;
hold on;
grid on;
fplot(theta_2_sol, [0, xmax])
xlabel("$U$ displacement")
ylabel("$\theta$ displacement")











%[appendix]
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":45.8}
%---
