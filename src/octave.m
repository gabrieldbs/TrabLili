%// Funciones octave
%// 
%//1
function f_ha(f_a,rho_h_mas,ka)
	f_ha=rho_h_mas*f_a/ka
endfunction

%//2
function f_hap(f_a,rho_h_mas,ka)
	f_hap=1-f_a-rho_h_mas*f_a/ka;
endfunction

%//3
function f_eop(f_a,rho_h_mas,ka)
	f_eop= 1-f_a-rho_h_mas*f_a/ka;
endfunction

%//4
function f_eo(f_a,rho_h_mas,ka)
	f_eo=f_a*(1+rho_h_mas/ka);
endfunction
%//5
function rho_h_mas(psi,beta,rho_h,qh)
	rho_h_mas=rho_h*exp(-beta*psu*qh)
endfunction
%//6
function rho_a_menos(psi,beta,rho_a,qa)
	rho_a_menos=rho_a*exp(-beta*psi*q_a)
endfunction
%//ecuacion1
function ecuacion1(f_a,psi,ka,beta,q_h,kd,rho_o,rho_h)
	ecuacion1=f_a*(1+rho_h*(exp(-beta*psi*q_h))/ka)+(kd/ka)*rho_o*f_a*rho_h*(exp(-beta*psi*qh))*(f_a+f_a*rho_h*(exp(-beta*psi*qh))/ka)
endfunction
%//ecuacion2
function ecuacion2(f_a,psi,beta,qa,qh,rho_a,rho_h,rho_o)
	ecuacion2=rho_a*exp(-beta*psi*q_a)+rho_of_a+rho_h*exp(-beta*psi*q_h)
endfunction
