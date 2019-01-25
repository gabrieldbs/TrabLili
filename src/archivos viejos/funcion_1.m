function F = funcion_1(f_a,ps_i,rho_o,kd)

  %-------------------------------------ECUACIONES DEFINICIONES---------------------------------------------%

  %DEFINO CONSTANTES PERO DESPUES LO HAGO MAS PROLIJO
  %MI IDEA ES SOLO PASAR F_A Y PS_I. 
  bet_a=0;
  rho_a=1;
  rho_h=1;
  q_a=0;
  q_h=0;
  ka=1;

  %ECUACIONES
  
  %ecuacion1
  F(1) = @(f_a,ps_i) f_a*(1+rho_h*(exp(-bet_a*ps_i*q_h))/ka)+(kd/ka)*rho_o*f_a*rho_h*(exp(-bet_a*ps_i*q_h))*(f_a+f_a*rho_h*(exp(-bet_a*ps_i*q_h))/ka);
  %testec1=ecuacion1(1,1);
  %-----------------------------------------%
  %//ecuacion2
  F(2) = @(f_a,ps_i) rho_a*exp(-bet_a*ps_i*q_a)+rho_o*f_a+rho_h*exp(-bet_a*ps_i*q_h);
  %testec2=ecuacion2(1,0);
 
endfunction
