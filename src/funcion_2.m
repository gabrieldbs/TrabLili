function F2 = funcion_2(f_a,ps_i)
  %%-----------------------
  % LA IDEA ES QUE F2 SEA UN ARRAY DE 8 VARIABLES RESUELTAS,
  %F2=[f_a,f_ha,f_hap,f_eo,f_eop,rho_h_mas,rho_a_menos,psi]
  %%-------CONSTANTES-----------------%
  
  
  %-----------------VARIABLES---------------%
  F2(1)=f_a;
  f_ha = @(f_a,rho_h_mas,ka) rho_h_mas*f_a/ka;
  F2(2)=f_ha;
  f_hap = @(f_a,rho_h_mas,ka) 1-f_a-rho_h_mas*f_a/ka;
  F2(3)=f_hap;
  
  f_eo= @(f_a,rho_h_mas,ka) f_a*(1+rho_h_mas/ka);
  F2(4)=f_eo;
  f_eop = @(f_a,rho_h_mas,ka) 1-f_a-rho_h_mas*f_a/ka;
  F2(5)=f_eop;
  
  rho_h_mas= @(ps_i,bet_a,rho_h,q_h) rho_h*exp(-bet_a*ps_i*q_h);
  F2(6)=rho_h_mas;
  rho_a_menos=@(ps_i,bet_a,rho_a,q_a) rho_a*exp(-bet_a*ps_i*q_a);
  F2(7)=rho_h_menos;
  
  F2(8)=ps_i;
 endfunction;
 
