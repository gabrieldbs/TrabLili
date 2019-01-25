%%---------------------------------------------------------%%
%%---------------------------------------------------------%%
%% SOLO SON FUNCIONES Y COSAS COLGADAS QUE USE EN OTROS  ARCHIVOS
%%---------------------------------------------------------%%
%%---------------------------------------------------------%%


%// Funciones octave
%
%-----------------------------------------%
%FUNCIONES  Fi Y RHOi  son 6 mas dos ecuaciones
% Lo  defini como funciones de manera explicita o como funciones con el @
% Me parece que conviene definir todas las  funciones con @ asique las reescribo y despues veo con que me quedo
% Osea que van a  estar todas las definiciones dos veces el tema 
% es que para funciones hay que separarlo en diferentes carpetas  y no se  si vale la pena
%//1
%-----------------------------------------%
function f_ha(f_a,rho_h_mas,ka)
	f_ha=rho_h_mas*f_a/ka
endfunction
test1=f_ha(1,1,1);

	f_ha = @(f_a,rho_h_mas,ka) rho_h_mas*f_a/ka;

%-----------------------------------------%

%//2
function f_hap(f_a,rho_h_mas,ka)
	f_hap=1-f_a-rho_h_mas*f_a/ka;
endfunction
test2=f_hap(1,1,1);

	f_hap = @(f_a,rho_h_mas,ka) 1-f_a-rho_h_mas*f_a/ka;

%-----------------------------------------%

%//3
function f_eop(f_a,rho_h_mas,ka)
	f_eop= 1-f_a-rho_h_mas*f_a/ka;
endfunction
test3=f_eop(1,1,1);

	f_eop = @(f_a,rho_h_mas,ka) 1-f_a-rho_h_mas*f_a/ka;
%-----------------------------------------%
%//4
function f_eo(f_a,rho_h_mas,ka)
	f_eo=f_a*(1+rho_h_mas/ka);
endfunction
test4=f_eop(1,1,1);

	f_eo= @(f_a,rho_h_mas,ka) f_a*(1+rho_h_mas/ka);
%-----------------------------------------%

%//5
function rho_h_mas(ps_i,bet_a,rho_h,q_h)
	rho_h_mas=rho_h*exp(-bet_a*ps_i*q_h);
endfunction
test5=rho_h_mas(1,1,1,1)/exp(-1);

	rho_h_mas= @(ps_i,bet_a,rho_h,q_h) rho_h*exp(-bet_a*ps_i*q_h);
%-----------------------------------------%
%//6
function rho_a_menos(ps_i,bet_a,rho_a,q_a)
	rho_a_menos=rho_a*exp(-bet_a*ps_i*q_a);
endfunction
test6=rho_a_menos(1,1,1,1)/exp(-1);

	rho_a_menos=@(ps_i,bet_a,rho_a,q_a) rho_a*exp(-bet_a*ps_i*q_a);
%--------------------------------------------------------------------------%
%TESTEOS la suma de las  f tiene que dar 1


function suma_fracciones_a(f_a,f_ha,f_hap)
	suma_fracciones_a=f_a+f_ha+f_hap;
endfunction

%-----------------------------------------%
function suma_fracciones_b(f_eo,f_eop)
	suma_fracciones_b=f_ep+f_eop;
endfunction


%--------------------------------------------------------------------------%


%ECUACIONES

%ecuacion1
bet_a=0;
rho_a=1;
rho_h=1;
rho_o=1;
q_a=0;
q_h=0;
kd=1;
ka=1;

 ecuacion1 = @(f_a,ps_i) f_a*(1+rho_h*(exp(-bet_a*ps_i*q_h))/ka)+(kd/ka)*rho_o*f_a*rho_h*(exp(-bet_a*ps_i*q_h))*(f_a+f_a*rho_h*(exp(-bet_a*ps_i*q_h))/ka);
testec1=ecuacion1(1,1);

%-----------------------------------------%
%//ecuacion2
bet_a=0;
rho_a=1;
rho_h=1;
rho_o=1;
q_a=0;
q_h=0;
ecuacion2 = @(f_a,ps_i) rho_a*exp(-bet_a*ps_i*q_a)+rho_o*f_a+rho_h*exp(-bet_a*ps_i*q_h);
testec2=ecuacion2(1,0);


%--------------------------------------------------------------------------------%
%VOY A DIVIDIR LA ELIBRE EN CADA UNO DE LOS TERMINOS  Y  DESPUES LOS SUMO

function EnLi_1(rho_a_menos,vol_a_menos, muo_a_menos)
	EnLi_1=rho_a_menos*log(rho_a_menos*v_a_menos)-1+muo_a_menos;
endfunction
testEl1=EnLi_1(1,1,1);

	EnLi_1= @(rho_a_menos,vol_a_menos, muo_a_menos) rho_a_menos*log(rho_a_menos*v_a_menos)-1+muo_a_menos;
%---------------------------------------%
function EnLi_2(rho_h_mas,vol_h_mas, muo_h_mas)
	EnLi_2=rho_h_mas*log(rho_h_mas*v_h_mas)-1+muo_h_mas;
endfunction
testEl2=EnLi_2(1,1,1);

	EnLi_2=@(rho_h_mas,vol_h_mas, muo_h_mas) rho_h_mas*log(rho_h_mas*v_h_mas)-1+muo_h_mas;
%---------------------------------------%
function EnLi_3(rho_o,f_ha,f_a,f_hap)
	EnLi_3=rho_o*( f_ha*log(f_ha)+ f_a*log(f_a) +f_hap*log(f_hap));
endfunction
testEl3=EnLi_3(1,1,1,1);

	EnLi_3=@(rho_o,f_ha,f_a,f_hap) rho_o*( f_ha*log(f_ha)+ f_a*log(f_a) +f_hap*log(f_hap));
%---------------------------------------%
function EnLi_4(rho_o,f_eo,f_eop,bet_a,muo_eo)
	EnLi_4=rho_o*( f_eo*log(f_eo) +f_eop*log(f_eop)	+f_eo*bet_a*muo_eo);
endfunction
testLi_4=EnLi_4(1,1,1,1,1);

	EnLi_4= @(rho_o,f_eo,f_eop,bet_a,muo_eo) rho_o*( f_eo*log(f_eo) +f_eop*log(f_eop)	+f_eo*bet_a*muo_eo);
%---------------------------------------%
function EnLi_5(rho_o,f_eop,bet_a,muo_eop,v_pair)
	EnLi_5=rho_o*f_eop*( bet_a+muo_eop-log(rho_o*f_eop+v_pair)+ 1 );
endfunction
testLi5=EnLi_5(1,1,1,1,1);

	EnLi_5=@rho_o,f_eop,bet_a,muo_eop,v_pair) rho_o*f_eop*( bet_a+muo_eop-log(rho_o*f_eop+v_pair)+ 1 );
%---------------------------------------%
function EnLi_6(rho_o,f_a,muo_a,muo_ha,f_ha)
	EnLi_6=rho_o* (f_ha*muo_ha+f_a*muo_a );
endfunction
testLi6=EnLi_6(1,1,1,1);

	EnLi_6=@(rho_o,f_a,muo_a,muo_ha,f_ha) rho_o* (f_ha*muo_ha+f_a*muo_a );
%---------------------------------------%
function EnLi_7(rho_a_menos,mu_a_menos,rho_h_mas,mu_h_mas,mu_h,f_ha,rho_o)
	EnLi_7=rho_a_menos*mu_a_menos+rho_h_mas*mu_h_mas+mu_h*f_ha*rho_o;
endfunction
testLi7=EnLi_7(1,1,1,1,1,1,1);

	EnLi_7=@(rho_a_menos,mu_a_menos,rho_h_mas,mu_h_mas,mu_h,f_ha,rho_o) rho_a_menos*mu_a_menos+rho_h_mas*mu_h_mas+mu_h*f_ha*rho_o;
%---------------------------------------%
function EnLi_8(ps_i,rho_a_menos,rho_h_mas,q_a,q_h,rho_o,f_a)
	EnLi_8=ps_i*(rho_a_menos*q_a+rho_h_mas*q_h+rho_o*f_a*q_a );
endfunction
testLi8=EnLi_8(1,1,1,1,1,1,1);

	EnLi_8=@(ps_i,rho_a_menos,rho_h_mas,q_a,q_h,rho_o,f_a) ps_i*(rho_a_menos*q_a+rho_h_mas*q_h+rho_o*f_a*q_a );

%----------------------------------------------------------------------------------%

%ENERGIA LIBRE
function EnLiTot(EnLi_1,EnLi_2,EnLi_3,EnLi_4,EnLi_5,EnLi_6,EnLi_7,EnLi_8)
	EnLiTot=EnLi_1EnLi_2+EnLi_3+EnLi_4+EnLi_5+EnLi_6+EnLi_7+EnLi_8;
endfunction

