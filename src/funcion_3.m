function F3= funcion_3(Y)

  EnLi_1= @(rho_a_menos,vol_a_menos, muo_a_menos) rho_a_menos*log(rho_a_menos*v_a_menos)-1+muo_a_menos;
%---------------------------------------%  
  EnLi_2=@(rho_h_mas,vol_h_mas, muo_h_mas) rho_h_mas*log(rho_h_mas*v_h_mas)-1+muo_h_mas;
%---------------------------------------%
  EnLi_3=@(rho_o,f_ha,f_a,f_hap) rho_o*( f_ha*log(f_ha)+ f_a*log(f_a) +f_hap*log(f_hap));
%---------------------------------------%
	EnLi_4= @(rho_o,f_eo,f_eop,bet_a,muo_eo) rho_o*( f_eo*log(f_eo) +f_eop*log(f_eop)	+f_eo*bet_a*muo_eo);
%---------------------------------------%
  EnLi_5=@rho_o,f_eop,bet_a,muo_eop,v_pair) rho_o*f_eop*( bet_a+muo_eop-log(rho_o*f_eop+v_pair)+ 1 );
%---------------------------------------%
  EnLi_6=@(rho_o,f_a,muo_a,muo_ha,f_ha) rho_o* (f_ha*muo_ha+f_a*muo_a );
%---------------------------------------%
  EnLi_7=@(rho_a_menos,mu_a_menos,rho_h_mas,mu_h_mas,mu_h,f_ha,rho_o) rho_a_menos*mu_a_menos+rho_h_mas*mu_h_mas+mu_h*f_ha*rho_o;
%---------------------------------------%
  EnLi_8=@(ps_i,rho_a_menos,rho_h_mas,q_a,q_h,rho_o,f_a) ps_i*(rho_a_menos*q_a+rho_h_mas*q_h+rho_o*f_a*q_a );

%------------------------------------------------------------------------------%
  EnLiTot=EnLi_1EnLi_2+EnLi_3+EnLi_4+EnLi_5+EnLi_6+EnLi_7+EnLi_8;
  F3=EnLiTot;
endfunction;
