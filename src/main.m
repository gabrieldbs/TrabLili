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

%%-----------------ALGUNAS DEFINICIONES QUE VOY A USAR DENTRO DEL PROGRAMA--------------%%
%%Xo va a ser la semilla de la convergencia
%%X va a ser  la solucion f_a y ps_i
%%Y va a ser un array con todas las variables resueltas
%%--------------------------------------%%

for i=kd_min:1:kd_max
	kd=10^i;

	for rho_o=rh_o_min: paso:rho_o_max
		%%------------FSOLVE---------------%%
		fun= @funcion_1; %% CHEQUEAR SI LA NOTACION ES CORRECTA
		Xo=[0,0];
		X= fsolve(fun,Xo); %% CHEQUEAR OPCIONES QUE SE LE PUEDE AGREGAR FALTA VER QUE PASA CON RHO Y KD
		%------------------aca  atras pueden haaber errores de notacion chequear%
		
		%%---DEBERIA TENER PSI Y F_A----------%%
		f_a=X(1);
		ps_i=X(2);
		%%------ECUACIONES------------------%%
		Y=funcion_2(f_a,ps_i) %%  ACA LA IDEA ES TENER TODAS LAS VARIABLES
		%%---------ELT-------------------%%
		Etot=funcion_3(Y,rho_o)	%% ACA LA IDEA ES QUE LA FUNCION  SUME  TODAS LAS CONTRIBUCIONESEN UNA ETOTAL
		
		%%-----------CUANDO SALGO DEL FOR QUIERO QUE AGREGUE UNA LINEA EN EL TXT-----
		
	end
	
end

%--------------cosas que faltan---------------%

%%funcion_1 que resuelva las ecuaciones
%%funcion_2 que despues de tener psi y fa  consiga todas las demas
%%funcion_3 que  resuelva la energia libre
%%generar un comando que abra un archivo y llene con rho_0 y elibre para cada kd
