function F2 = funcion_2(X)
  %%-----------------------
  % LA IDEA ES QUE F2 SEA UN ARRAY DE 8 VARIABLES RESUELTAS,
  %F2=[f_a,psi,rho_h_mas,rho_a_menos,f_ha,f_hap,f_eo,f_eop]
  %Y=[f_a (1),psi (2),rho_h_mas (3) ,rho_a_menos (4) ,f_ha (5) ,f_hap (6),f_eo (7),f_eop(8)]
  %%-------CONSTANTES-----------------%
  ka=1;
  bet_a=1;
  q_h=1;
  q_a=1;
  rho_h=1;
  rho_a=1; 
  %-----------------VARIABLES---------------%
  
  F2(1)=X(1);
  F2(2)=X(2);
  rho_h_mas= rho_h*exp(-bet_a*X(2)*q_h);
  F2(3)=rho_h_mas;
  rho_a_menos= rho_a*exp(-bet_a*X(2)*q_a);
  F2(4)=rho_h_menos;
  
  f_ha = rho_h_mas*X(1)/ka;
  F2(5)=f_ha;
  f_hap = 1-X(1)-rho_h_mas*X(1)/ka;
  F2(6)=f_hap;
  
  f_eo= X(1)*(1+rho_h_mas/ka);
  F2(7)=f_eo;
  f_eop = 1-X(1)-rho_h_mas*X(1)/ka;
  F2(8)=f_eop;
  
 endfunction;
 
