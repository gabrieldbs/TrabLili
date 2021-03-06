function main
clear all;
       		%----------------------%
		% ACA EMPIEZO ARMAR EL PROGRAMA QUE ITERE ELIB EN FUNCION RHO_O Y KD
		%-------------------------%
% DEFINICIONES GLOBALES
pkg load optim

global bet_a
global kd
global ka
global rho_h_bulk
global rho_a_bulk    
global rho_o
global psi
global f_A

rho_o = 0.85; % monomer concentration in film (M); habiamos dicho de poner aprox 1
vpair = 1.0 ;% CHECKEAr
Temp=298;  % ------ K ------%
bet_a=96485/(Temp*8.3144);		% |e|/kT in V^-1

%kd=10^5;

%%-----------------ALGUNAS DEFINICIONES QUE VOY A USAR DENTRO DEL PROGRAMA--------------%%

epsi=10^(-5);
phmax=14;
paso=0.2;
%fid = fopen('fa_ph.txt',a);%aca no se si va w o s o sino va nada 
	for kdexp=0:1:10
		kd=10^(kdexp);
		i=0;
		for ph=0:paso:phmax
			i=i+1;
			rho_h_bulk=10^(-ph);	
			rho_a_bulk=10^(-ph);
			ka=10^(-ph);		%% A CHEQUEAR O PREGUNTAR 
			m=0;
			f_A = 0.5;		 %% initial conditions for solver
			psi = 0;		 %% initial conditions for solver
			lbounds = [0 -inf];	 %% bounds of  f_A and psi
			ubounds = [1 inf]; 	 %% bounds of  f_A and psi
			Xo=[f_A,psi];		 %% CONDICIONES INICIALES PARA EL FSOLV Xo=[f_a,ps_i]%   
			options = optimset('Tolfun', 1E-12, 'TolX', 1e-12, 'MaxFunEvals', 10000);
			[X resnorm] = lsqnonlin(@myfun,Xo,lbounds,ubounds, options); 		
			%myfun(X);     
			%resnorm;	
			psi = X(2);
			f_A = X(1);
			m(kdexp*(ph_max/paso)+i)=[f_A];
			%fprintf(fid, '%f \t %f\n', m(1),m(2) );		
		end
	end
	
%fclose(fid);
m
end

%%------------------funciones para fsolve--------------------%%%
function  F = myfun(X)
    
global bet_a
global kd
global ka
global rho_h_bulk
global rho_a_bulk    
global rho_o

X;

F(1) = X(1)*(1+rho_h_bulk*(exp(-bet_a*X(2)))/ka)+(kd/ka)*rho_o*X(1)*rho_h_bulk*(exp(-bet_a*X(2)))*(X(1)+X(1)*rho_h_bulk*(exp(-bet_a*X(2)))/ka)-1;
F(2) = rho_a_bulk*exp(bet_a*X(2))+rho_o*X(1)-rho_h_bulk*exp(-bet_a*X(2));

end 
