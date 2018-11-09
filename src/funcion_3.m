function F3= funcion_3(Y,rho_o)
%Y=[f_a (1),psi (2),rho_h_mas (3) ,rho_a_menos (4) ,f_ha (5) ,f_hap (6),f_eo (7),f_eop(8)]
%-----------------------------CONSTANTES--------------%
v_a_menos=1;
muo_a_menos=1;
v_h_mas=1;
muo_h_mas=1;
bet_a=1;
muo_eo=1;
muo_eop=1;
v_pair=1;
muo_ha=1;
muo_a=1;
mu_a_menos=1;
mu_h_mas=1;
mu_h=1;
q_a=-1;
q=h=1;
%%--------------------------VARIABLES--------------%


  EnLi_1= Y(4)*log(Y(4)*v_a_menos)-1+muo_a_menos;
%----------------------------------------------%  
  EnLi_2= Y(3)*log(Y(3)*v_h_mas)-1+muo_h_mas;
%---------------------------------------%
  EnLi_3= rho_o*( Y(5)*log(Y(5))+ Y(1)*log(Y(1)) +Y(6)*log(Y(6)));
%---------------------------------------%
  EnLi_4=  rho_o*( Y(7)*log(Y(7)) +Y(8)*log(Y(8)) +Y(7)*bet_a*muo_eo);
%---------------------------------------%
  EnLi_5= rho_o*Y(8)*( bet_a+muo_eop-log(rho_o*Y(8)+v_pair)+ 1 );
%---------------------------------------%
  EnLi_6= rho_o* (Y(5)*muo_ha+Y(1)*muo_a );
%---------------------------------------%
  EnLi_7=  Y(4)*mu_a_menos+Y(3)*mu_h_mas+mu_h*Y(5)*rho_o;
%---------------------------------------%
  EnLi_8=  Y(2)*(Y(4)*q_a+Y(3)*q_h+rho_o*Y(1)*q_a );

%------------------------------------------------------------------------------%
  EnLiTot=EnLi_1EnLi_2+EnLi_3+EnLi_4+EnLi_5+EnLi_6+EnLi_7+EnLi_8;
  F3=EnLiTot;
endfunction;
