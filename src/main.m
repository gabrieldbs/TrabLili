%----------------------%
% ACA EMPIEZO ARMAR EL PROGRAMA QUE ITERE ELIB EN FUNCION RHO_O Y KD
%-------------------------%

%---------------------------%
%-------------------DEFINO VARIABLES-------------RHO_O Y KD
%---------------------------%

%Defino El maximo , el minimo y el paso del rho_o
%n=cantidad de iteraciones

rho_o_min=0.01;
rho_o_max=0.99;
nrho=100;
paso=(rho_o_min+rho_o_max)/nrho;
%DE KD SOLO PONGO EL EXPONENTE PORQUE ES MAS FACIL PARA EL FOR 
kd_max=-5;
kd_min=10; 

%---------------------------%
%-------------------DEFINO CONSTANTES  A CHEQUEAR---------------
%---------------------------%

ka=1;
rho_h=0.5;
rho_a=0.5;
bet_a=1;
q_a=-1;
q_h=1;
%ps_i=0;
%f_a=0.1;
vol_a_menos=1;
vol_h_mas=1;
vol_pair=1;
muo_a_menos=1;
muo_h_mas=1;
muo_eo=1;
muo_eop=1;
muo_a=1;
muo_ha=1;
epsi=2;
%%-----------------ALGUNAS DEFINICIONES QUE VOY A USAR DENTRO DEL PROGRAMA--------------%%
%%Xo va a ser la semilla de la convergencia
%%X va a ser  la solucion f_a y ps_i
%%Y va a ser un array con todas las variables resueltas
%%--------------------------------------%%

for i=kd_min:1:kd_max
	kd=10^i;
	fid = fopen('Ener_lib_'i'.txt', 'w');
	for rho_o=rh_o_min: paso:rho_o_max
		%%------------FSOLVE---------------%%
		
		%		LAS DOS FUNCIONES JUNTAS  COMO FUNC=[EQ1;EQ2]
		Func =  @(X) [X(1)*(1+rho_h*(exp(-bet_a*X(2)*q_h))/ka)+(kd/ka)*rho_o*X(1)*rho_h*(exp(-bet_a*X(2)*q_h))*(X(1)+X(1)*rho_h*(exp(-bet_a*X(2)*q_h))/ka)-1; rho_a*exp(-bet_a*X(2)*q_a)+rho_o*X(1)+rho_h*exp(-bet_a*X(2)*q_h)]-1;
		% CONDICIONES INICIALES PARA EL FSOLV Xo=[f_a,ps_i]%
		Xo=[0.2,0.5];	%%
		X= fsolve(Func,Xo); % ACA FALTA AGREGARLE LIMITES A LAS VARIABLES  TODABIA NO SE COMO HACERLO
		check=sqrt(Func(X)(1)^2+Func(X)(2)^2 )
		if (check<epsi)
			%%---DEBERIA TENER PSI Y F_A----------%%
			%f_a=X(1);
			%ps_i=X(2);
			%%------ECUACIONES------------------%%
			Y=funcion_2(X); %%  ACA LA IDEA ES TENER TODAS LAS VARIABLES
			%F2=[f_a,psi,rho_h_mas,rho_a_menos,f_ha,f_hap,f_eo,f_eop]
			Z=[Y,rho_o];
			%%---------ELT-------------------%%
			Etot=funcion_3(Z);	%% ACA LA IDEA ES QUE LA FUNCION  SUME  TODAS LAS CONTRIBUCIONESEN UNA ETOTAL
			%%-----------CUANDO SALGO DEL FOR QUIERO QUE AGREGUE UNA LINEA EN EL TXT-----
			m=[kd,rho_o,Etot];
			
			fprintf(fid, 'rho_o \t Energia Libre\n\n');
			fprintf(fid, '%f \t %f \t %f\n', m(1),m(2),m(3)) );
			fclose(fid);
			
		end
		
	end
	
end

%--------------cosas que faltan---------------%
%%generar un comando que abra un archivo y llene con rho_0 y elibre para cada kd


