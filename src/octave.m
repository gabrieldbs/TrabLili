%// Funciones octave
%// 
%-----------------------------------------%
%FUNCIONES  Fi Y RHOi  son 6 mas dos ecuaciones

%//1
%-----------------------------------------%
function f_ha(f_a,rho_h_mas,ka)
	f_ha=rho_h_mas*f_a/ka
endfunction
test1=f_ha(1,1,1);

%-----------------------------------------%

%//2
function f_hap(f_a,rho_h_mas,ka)
	f_hap=1-f_a-rho_h_mas*f_a/ka;
endfunction
test2=f_hap(1,1,1);

%-----------------------------------------%

%//3
function f_eop(f_a,rho_h_mas,ka)
	f_eop= 1-f_a-rho_h_mas*f_a/ka;
endfunction
test3=f_eop(1,1,1);


%-----------------------------------------%
%//4
function f_eo(f_a,rho_h_mas,ka)
	f_eo=f_a*(1+rho_h_mas/ka);
endfunction
test4=f_eop(1,1,1);

%-----------------------------------------%

%//5
function rho_h_mas(psi,beta,rho_h,q_h)
	rho_h_mas=rho_h*exp(-beta*psi*q_h)
endfunction
test5=rho_h_mas(1,1,1,1)/exp(-1);

%-----------------------------------------%
%//6
function rho_a_menos(psi,beta,rho_a,q_a)
	rho_a_menos=rho_a*exp(-beta*psi*q_a)
endfunction
test6=rho_a_menos(1,1,1,1)/exp(-1);

%-----------------------------------------%
%TESTEOS
function suma_fracciones_a(f_a,f_ha,f_hap)
	suma_fracciones_a=f_a+f_ha+f_hap
endfunction

%-----------------------------------------%
function suma_fracciones_b(f_eo,f_eop)
	suma_fracciones_b=f_ep+f_eop
endfunction


%-----------------------------------------%
%ECUACIONES

%ecuacion1
beta=0;
rho_a=1;
rho_h=1;
rho_o=1;
q_a=0;
q_h=0;
kd=1;
ka=1;
 ecuacion1 = @(f_a,psi) f_a*(1+rho_h*(exp(-beta*psi*q_h))/ka)+(kd/ka)*rho_o*f_a*rho_h*(exp(-beta*psi*q_h))*(f_a+f_a*rho_h*(exp(-beta*psi*q_h))/ka);
testec1=ecuacion1(1,1);

%-----------------------------------------%
%//ecuacion2
beta=0;
rho_a=1;
rho_h=1;
rho_o=1;
q_a=0;
q_h=0;
ecuacion2 = @(f_a,psi) rho_a*exp(-beta*psi*q_a)+rho_o*f_a+rho_h*exp(-beta*psi*q_h);
testec2=ecuacion2(1,0);


%-----------------------------------------%
%VOY A DIVIDIR LA ELIBRE EN CADA UNO DE LOS TERMINOS  Y  DESPUES LOS SUMO

function EnLi_1(rho_a_menos,vol_a_menos, muo_a_menos)
	EnLi_1=rho_a_menos*ln(rho_a_menos*v_a_menos)-1+muo_a_menos;
endfunction
testEl1=EnLi_1(1,1,1);

function EnLi_2(rho_h_mas,vol_h_mas, muo_h_mas)
	EnLi_2=rho_h_mas*ln(rho_h_mas*v_h_mas)-1+muo_h_mas;
endfunction
testEl2=EnLi_2(1,1,1);

function EnLi_3(rho_o,f_ha,f_a,f_hap)
	EnLi_3=rho_o*( f_ha*ln(f_ha)+ f_a*ln(f_a) +f_hap*ln(f_hap));
endfunction
testEl3=EnLi_3(1,1,1,1);

function EnLi_4(rho_o,f_eo,f_eop,beta,muo_eo)
	EnLi_4=rho_o*( f_eo*ln(f_eo) +f_eop*ln(f_eop)	+f_eo*beta*muo_eo);
endfunction
testLi_4=EnLi_4(1,1,1,1,1);

function EnLi_5(rho_o,f_eop,beta,muo_eop,v_pair)
	EnLi_5=rho_o*f_eop*( beta+muo_eop-ln(rho_o*f_eop+v_pair)+ 1 );
endfunction
testLi5=EnLi_5(1,1,1,1,1);

function EnLi_6(rho_o,f_a,muo_a,muo_ha,f_ha)
	EnLi_6=rho_o* (f_ha*muo_ha+f_a*muo_a );
endfunction
testLi6=EnLi_6(1,1,1,1);

function EnLi_7(rho_a_menos,mu_a_menos,rho_h_mas,mu_h_mas,mu_h,f_ha,rho_o)
	EnLi_7=rho_a_menos*mu_a_menos+rho_h_mas*mu_h_mas+mu_h*f_ha*rho_o;
endfunction
testLi7=EnLi_7(1,1,1,1,1,1,1);

function EnLi_8(psi,rho_a_menos,rho_h_mas,q_a,q_h,rho_o,f_a)
	EnLi_8=psi*(rho_a_menos*q_a+rho_h_mas*q_h+rho_o*f_a*q_a );
endfunction
testLi8=EnLi_8(1,1,1,1,1,1,1);
%-----------------------------------------%

%ENERGIA LIBRE
function EnLiTot(EnLi_1,EnLi_2,EnLi_3,EnLi_4,EnLi_5,EnLi_6,EnLi_7,EnLi_8)
	EnLiTot=EnLi_1EnLi_2+EnLi_3+EnLi_4+EnLi_5+EnLi_6+EnLi_7+EnLi_8;
endfunction
