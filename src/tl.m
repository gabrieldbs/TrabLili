function main
clear all;
       		 %----------------------%
		% ACA EMPIEZO ARMAR EL PROGRAMA QUE ITERE ELIB EN FUNCION RHO_O Y KD
		%-------------------------%
% DEFINICIONES GLOBALES

global bet_a
global kd
global ka
global rho_h_bulk
global rho_a_bulk    
global rho_o
global psi
global f_A

vpair = 1.0 % CHECKEAr

%Defino El maximo , el minimo y el paso del rho_o
%n=cantidad de iteraciones
rho_o_min=0.01;  
rho_o_max=0.99;
nrho=100;
paso=(rho_o_min+rho_o_max)/nrho;

%DE KD SOLO PONGO EL EXPONENTE PORQUE ES MAS FACIL PARA EL FOR 
% kd_max=-5;
% kd_min=10; 
			%---------------------------%
			%-------------------DEFINO CONSTANTES 
			%---------------------------%
   
ka = 0.001;
rho_h_bulk=0.001;		% bulk density of H+ (M)
rho_a_bulk=0.001;		% bulk density of A- (M)

Temp=298;  % ------ K ------%
bet_a=96485/(Temp*8.3144);		% |e|/kT in V^-1


%vol_a_menos=1;		%-------------VOLUMENES------------%
%vol_h_mas=1;
%vol_pair=1;		%---------------VOLUMENES-------------------%

%muo_a_menos=1;		%--------------------- TODOS ESTOS MU HAY QUE  VER CUALES SON DATO.---.----%%%%%%
%muo_h_mas=1;		%---------------------  Y CUALES HAY QUE RELACIONAR CON EL NUEVO VINCULO--.%%%%%%
%muo_eo=1;
%muo_eop=1;
%muo_a=1;
%muo_ha=1;		% ----------------------------HASTA ACA MU---------------------------------------------%%%%%

%epsi=1;			% VA A SER EL LIMITE DEL CRITERIO A PEDIR DEL FSOLV	

%%-----------------ALGUNAS DEFINICIONES QUE VOY A USAR DENTRO DEL PROGRAMA--------------%%
%%Xo va a ser la semilla de la convergencia
%%X va a ser  la solucion f_a y ps_i
%%Y va a ser un array con todas las variables resueltas
%%Z va ser Y mas rho_o en un array

		%%--------------------------------------%%
%fid = fopen('Ener_lib_kd.txt',a);%aca no se si va w o s o sino va nada 
%inicialmente queria abrir un archivo por cada kd pero voy a ver si no hago un solo .txt

%for i=kd_min:1:kd_max 

kd=10^5;
rho_o = 0.5 % monomer concentration in film (M)

%fid = fopen('Ener_lib_%d.txt',i);  %esto es si quiero cada archivo separado
%fprintf(fid, 'rho_o \t Energia Libre \t \n\n');			

%	for rho_o=rh_o_min: paso:rho_o_max
		%%--SETEO A CERO ----------FSOLVE---------------%%      
%     		X=0;  % vector de salida para lsnqnonlin        
%		Y=0;
%		Z=0;
%    		Etot=0;
%        	m=0;
%%%% INITIAL CONDITIONS FOR SOLVER
	f_A = 0.5;
 	psi = 0;

 	lbounds = [0 -inf]; %% bounds of  f_A and psi
 	ubounds = [1 inf];
        Xo=[f_A,psi];	%%% CONDICIONES INICIALES PARA EL FSOLV Xo=[f_a,ps_i]%
      
	options = optimset('Tolfun', 1E-12, 'TolX', 1e-12, 'MaxFunEvals', 10000);
        [X resnorm] = lsqnonlin(@myfun,Xo,lbounds,ubounds, options); 		
%       myfun(X)     
%       resnorm
        
psi = X(2)
f_A = X(1)

%% LAS DEMAS VARIABLES QUE FALTABAN

rho_h = rho_h_bulk*exp(-bet_a*psi)
rho_a= rho_a_bulk*exp(bet_a*psi)
f_ha = rho_h*f_A/ka
f_hap = 1-f_A-rho_h*f_A/ka
f_eo= f_A*(1+rho_h/ka)
f_eop = 1-f_A-rho_h*f_A/ka


%%%  CONTRIBUCIÓN A LA ENERGÍA 

F_mix_A = rho_a*(log(rho_a)-1);
F_mix_H = rho_h*(log(rho_h)-1);
F_mix_PA = rho_o*(f_ha*log(f_ha)+f_A*log(f_A)+f_hap*log(f_hap));
F_mix_EO = rho_o*(f_eo*log(f_eo) + f_eop*log(f_eop)) + rho_o*f_eop*(-log(rho_o*f_eop*vpair)+1);
F_murho_H = (-rho_h-rho_o*f_ha)*(log(rho_h)+psi*bet_a);
F_murho_A = -rho_a*(log(rho_a)-psi*bet_a);
F_muceros = rho_o*(-log(ka)*f_A - log(kd)*f_eo);

F_tot = (F_mix_A + F_mix_H + F_mix_PA + F_mix_EO + F_murho_H + F_murho_A + F_muceros)/rho_o



%         if (check<epsi)
% 			%%---DEBERIA TENER PSI Y F_A----------%%
% 			%f_a=X(1);%ps_i=X(2);
% 			%% HABRIA QUE CONSIDERAR EL ERROR %
% 			Y=funcion_2(X); %%  ACA LA IDEA ES TENER TODAS LAS VARIABLES
% 			%F2=[f_a,psi,rho_h_mas,rho_a_menos,f_ha,f_hap,f_eo,f_eop]
% 			Z=[Y,rho_o];
% 			%%---------ELT-------------------%%
% 			Etot=funcion_3(Z);	%% ACA LA IDEA ES QUE LA FUNCION  SUME  TODAS LAS CONTRIBUCIONESEN UNA ETOTAL
% 			m=[rho_o,Etot];
% 			fprintf(fid, '%f \t %f\n', m(1),m(2) );
% 			fclose(fid);
% 			
% 		else
%             XX= lsqnonlin(Func,X,[0 -4],[1 4]); 
% 			check=sqrt(Func(XX)(1)^2+Func(XX)(2)^2 );
% 			YY=funcion_2(XX); %% 
% 		    	ZZ=[YY,rho_o];
% 			Etot=funcion_3(ZZ);	%% ACA LA IDEA ES QUE LA FUNCION  SUME  TODAS LAS CONTRIBUCIONESEN UNA ETOTAL
% 			%%-----------CUANDO SALGO DEL FOR QUIERO QUE AGREGUE UNA LINEA EN EL TXT-----
% 			m=[rho_o,Etot];
% 			fprintf(fid, '%f \t %f\n', m(1),m(2) );
% 			fclose(fid);
% 			
% 		end
% %	end
% 	
% %end

end

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
