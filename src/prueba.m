pkg load optim
  lbounds = [0 -inf];	 %% bounds of  f_A and psi
  ubounds = [1 inf]; 	 %% bounds of  f_A and psi
	Xo=[f_A,psi];		 %% CONDICIONES INICIALES PARA EL FSOLV Xo=[f_a,ps_i]%   
	options = optimset('Tolfun', 1E-12, 'TolX', 1e-12, 'MaxFunEvals', 10000);
	[X resnorm] = lsqnonlin(@myfun,Xo,lbounds,ubounds, options); 
  