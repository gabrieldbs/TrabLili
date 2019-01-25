function fitdata(fitme)

% This function fits kinetic data cointained in data.txt using a system of
% differential equations
% 
% Last edited, Mario Tagliazucchi - 1/5/2012

% In order to modify this routine for another experiment/mechanism:
% 1) change the number of contanst and size of the guess and solution
% vectors
% 2) change the mechanism
% 3) change the plotting functions

global Nexp
global expe
global residual
global xsol
global t
global iter

color(1) = 'r';
color(2) = 'b';
color(3) = 'g';
color(4) = 'm';
color(5) = 'k';


% iteration counter
iter = 0;

% file containing the experimantal data 
% in the form of [time c1 c2 c3 c4 c5 ...]
% concentration data should be in M, time in s

expe = load('data.txt');

% initial guess
%constants, in M and s units
% 
% k(1) = 1.613967e-002 
% k(2) = 1.370687e-002  
% k(3) = 1.083734e-002 
% k(4) = 7.769152e-003 
% k(5) = 4.492153e-003 
% 
% k(6) = 194.0 % ISC1
% k(7) = 848.0; % slow ISC
% 
% k(8) = 80 % ks
% k(9) = 300 % kt
% k(10) = 6000 % kcR
% 
% k(11) = 0.4 % fraction of mechanism 1 for exp. 1 
% k(12) = 0.4 % fraction of mechanism 1 for exp. 1 
% k(13) = 0.4 % fraction of mechanism 1 for exp. 1 
% k(14) = 0.4 % fraction of mechanism 1 for exp. 1 
% k(15) = 1.0 % fraction of mechanism 1 for exp. 1 

k(1) = 1.434549e-003 
k(2) = 4.500000e-003 
k(3) = 4.499998e-003  
k(4) = 4.499997e-003  
k(5) = 4.500000e-003  
k(6) = 1.675977e-002  
k(7) = 1.086876e-002  
k(8) = 7.018539e-003  
k(9) = 3.903679e-003  
k(10) = 1.000000e-006  
k(11) = 4.131702e+003  
k(12) = 3.795155e+002  
k(13) = 2.955856e+002  
k(14) = 1.230395e+002  
k(15) = 6.687970e+003  
k(16) = 2.007470e+003 

Nexp = 5;

lw = zeros(size(k,2));
ub = ones(size(k,2)).*inf;

ub(1) = 4.5e-003;
ub(2) = 4.5e-003;
ub(3) = 4.5e-003;
ub(4) = 4.5e-003;
ub(5) = 4.5e-003;


ub(10) = 1e-6;

Nfit = size(k,2); % number of fitting parameters

%pass to initial guess vector

x0 = k;

%call solver
% Set an options file for LSQNONLIN to use the
% medium-scale algorithm 
% 
if (fitme == 1)
options = optimset('Largescale','off', 'MaxFunEvals', 2000, 'Tolx', 1e-14, 'LineSearchType', 'quadcubic');
[x,resnorm, residual, exitflag, output, lambda, jacobian] = lsqnonlin(@vect,x0, lw,ub,options);% Invoke optimizer
end
if (fitme == 0)
vect(x0);
x = x0;
end
% 
% ci = nlparci(x,residual,jacobian)
% for j = 1:size(x,2);
% err(j) = max(abs(ci(j,1)-x(j)), abs(ci(j,2)-x(j)));
% end;

%err(1:13) = 0;

% fprintf('Amax = %e +/- %e.\n',x(1), err(1))
% fprintf('keTs = %e +/- %e.\n',x(2), err(2))
% fprintf('keTt = %e +/- %e.\n',x(3), err(3))
% fprintf('kdecayct = %e +/- %e.\n',x(4), err(4))
% fprintf('kdecays = %e +/- %e.\n',x(5), err(5))
% fprintf('kisc = %e +/- %e.\n',x(6), err(6))


fprintf('k(1) = %e \n',x(1))
fprintf('k(2) = %e \n',x(2))
fprintf('k(3) = %e  \n',x(3))
fprintf('k(4) = %e  \n',x(4))
fprintf('k(5) = %e  \n',x(5))
fprintf('k(6) = %e  \n',x(6))
fprintf('k(7) = %e  \n',x(7))
fprintf('k(8) = %e  \n',x(8))
fprintf('k(9) = %e  \n',x(9))
fprintf('k(10) = %e  \n',x(10))
fprintf('k(11) = %e  \n',x(11))
fprintf('k(12) = %e  \n',x(12))
fprintf('k(13) = %e  \n',x(13))
fprintf('k(14) = %e  \n',x(14))
fprintf('k(15) = %e  \n',x(15))
fprintf('k(16) = %e  \n',x(16))

% 
% fprintf('k(1) = %e \n',err(1))
% fprintf('k(2) = %e \n',err(2))
% fprintf('k(3) = %e  \n',err(3))
% fprintf('k(4) = %e  \n',err(4))
% fprintf('k(5) = %e  \n',err(5))
% fprintf('k(6) = %e  \n',err(6))
% fprintf('k(7) = %e  \n',err(7))
% fprintf('k(8) = %e  \n',err(8))
% fprintf('k(9) = %e  \n',err(9))
% fprintf('k(10) = %e  \n',err(10))
% fprintf('k(11) = %e  \n',err(11))
% fprintf('k(12) = %e  \n',err(12))
% fprintf('k(13) = %e  \n',err(13))
% fprintf('k(14) = %e  \n',err(14))
% fprintf('k(15) = %e  \n',err(15))
% fprintf('k(16) = %e  \n',err(16))
% fprintf('k(17) = %e  \n',err(17))

for i = 1:size(t)-1
t0(i) = t(i+1);
end

% plot residuals
figure(2)
for j = 1:Nexp
semilogx(expe(:,1),residual(:,j),'o', 'MarkerEdgeColor',color(j));
hold all;
end

% title('Residuals')

% plot results
figure(1)
for j = 1:Nexp
semilogx(t0,xsol(:,j),color(j));
hold all;
semilogx(expe(:,1), expe(:,j+1), 'o','MarkerEdgeColor',color(j));
hold all;
end
title('Fitting')
% 
% 
% % plot results
% figure(3)
% for j = 1:Nexp
% semilogx(t0,xsol(:,j),color(j));
% hold all;
% end
% title('Fitting')

% save fitting curves to disk
xsave(:,1)=t0;
for i=1:size(xsol,2);
xsave(:,i+1)=xsol(:,i);
end
save('fit.txt', 'xsave', '-ASCII')
end

