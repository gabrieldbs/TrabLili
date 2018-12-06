		%----------------------%
		% ACA EMPIEZO ARMAR EL PROGRAMA QUE ITERE ELIB EN FUNCION RHO_O Y KD
		%-------------------------%

%Defino El maximo , el minimo y el paso del rho_o
%n=cantidad de iteraciones

pkg load optim %VOY A USAR EN VEZ DE FSOLVE ISQNONLIN PORQUE NO TIENE LIMITES FSOLVE


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
kboltz=8.617332*10^(-5);%-----------   [eV/K]  ----%
ka=1;			%-------------  DATO--------------------%	
rho_h=0.5;		%-------------  ME PARECE QUE ESTABA VINCULADO CON EL MONOMERO--------------------%
rho_a=0.5;		%-------------  ME PARECE QUE ESTABA VINCULADO CON EL MONOMERO--------------------%
Temp=300; 		% ------------   [K]   ------%
bet_a=1/(Temp*kboltz);	% ------------  [1/eV] ---------%
q_a=-1;			%-------------  [eV]   --------------------%
q_h=1;			%-------------  [eV ]  --------------------%

vol_a_menos=1;		%-------------VOLUMENES------------%
vol_h_mas=1;		%
vol_pair=1;		%---------------VOLUMENES-------------------%

muo_a_menos=1;		%--------------------- TODOS ESTOS MU HAY QUE  VER CUALES SON DATO.---.----%%%%%%
muo_h_mas=1;		%---------------------  Y CUALES HAY QUE RELACIONAR CON EL NUEVO VINCULO--.%%%%%%
muo_eo=1;
muo_eop=1;
muo_a=1;
muo_ha=1;		% ----------------------------HASTA ACA MU---------------------------------------------%%%%%

epsi=1;			% VA A SER EL LIMITE DEL CRITERIO A PEDIR DEL FSOLV	
		%%-----------------ALGUNAS DEFINICIONES QUE VOY A USAR DENTRO DEL PROGRAMA--------------%%
%%Xo va a ser la semilla de la convergencia
%%X va a ser  la solucion f_a y ps_i
%%Y va a ser un array con todas las variables resueltas
%%Z va ser Y mas rho_o en un array

		%%--------------------------------------%%
fid = fopen('Ener_lib_kd.txt',a);%aca no se si va w o s o sino va nada 
%inicialmente queria abrir un archivo por cada kd pero voy a ver si no hago un solo .txt
for i=kd_min:1:kd_max 
	kd=10^i;
	%fid = fopen('Ener_lib_%d.txt',i);  %esto es si quiero cada archivo separado
	fprintf(fid, 'rho_o \t Energia Libre \t \n\n');			
	for rho_o=rh_o_min: paso:rho_o_max
		%%--SETEO A CERO ----------FSOLVE---------------%%
		X=0;
		Y=0;
		Z=0;
		Etot=0;
		m=0;
		%		LAS DOS FUNCIONES JUNTAS  COMO FUNC=[EQ1;EQ2]; X(1)=f_a X(2)=ps_i
		Func =  @(X) [X(1)*(1+rho_h*(exp(-bet_a*X(2)*q_h))/ka)+(kd/ka)*rho_o*X(1)*rho_h*(exp(-bet_a*X(2)*q_h))*(X(1)+X(1)*rho_h*(exp(-bet_a*X(2)*q_h))/ka)-1; rho_a*exp(-bet_a*X(2)*q_a)+rho_o*X(1)+rho_h*exp(-bet_a*X(2)*q_h)-1];
		Xo=[0.2,0.5];	%%% CONDICIONES INICIALES PARA EL FSOLV Xo=[f_a,ps_i]%
		X= lsqnonlin(Func,Xo,[0 -4],[1 4])%LIMITES [X(1)MIN X(2)MIN],[X(1)MAX X(2)MAX] X(1) ESTA ENTRE (0 1) X(2) NO SE LOS LIMITES
		check=sqrt(Func(X)(1)^2+Func(X)(2)^2 ) %Tenia pensado chequear si estan dando cero y en caso de que no  iterar mas veces
		if (check<epsi)
			%%---DEBERIA TENER PSI Y F_A----------%%
			%f_a=X(1);%ps_i=X(2);
			%% HABRIA QUE CONSIDERAR EL ERROR %
			Y=funcion_2(X); %%  ACA LA IDEA ES TENER TODAS LAS VARIABLES
			%F2=[f_a,psi,rho_h_mas,rho_a_menos,f_ha,f_hap,f_eo,f_eop]
			Z=[Y,rho_o];
			%%---------ELT-------------------%%
			Etot=funcion_3(Z);	%% ACA LA IDEA ES QUE LA FUNCION  SUME  TODAS LAS CONTRIBUCIONESEN UNA ETOTAL
			m=[rho_o,Etot];
			fprintf(fid, '%f \t %f\n', m(1),m(2) );
			fclose(fid);
			
		else
                	XX= lsqnonlin(Func,X,[0 -4],[1 4]); 
			check=sqrt(Func(XX)(1)^2+Func(XX)(2)^2 );
			YY=funcion_2(XX); %% 
		    	ZZ=[YY,rho_o];
			Etot=funcion_3(ZZ);	%% ACA LA IDEA ES QUE LA FUNCION  SUME  TODAS LAS CONTRIBUCIONESEN UNA ETOTAL
			%%-----------CUANDO SALGO DEL FOR QUIERO QUE AGREGUE UNA LINEA EN EL TXT-----
			m=[rho_o,Etot];
			fprintf(fid, '%f \t %f\n', m(1),m(2) );
			fclose(fid);
			
		end
	end
	
end



