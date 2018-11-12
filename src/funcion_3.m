function F3= funcion_3(Z)
%Z=[f_a (1),psi (2),rho_h_mas (3) ,rho_a_menos (4) ,f_ha (5) ,f_hap (6),f_eo (7),f_eop(8),rho_o (9)]
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


  EnLi_1= Z(4)*(log(Z(4)*v_a_menos)-1+muo_a_menos);
%----------------------------------------------%  
  EnLi_2= Z(3)*(log(Z(3)*v_h_mas)-1+muo_h_mas);
%---------------------------------------%
  EnLi_3= Z(9)*( Z(5)*log(Z(5))+ Z(1)*log(Z(1)) +Z(6)*log(Z(6)) );
%---------------------------------------%
  EnLi_4=  Z(9)*( Z(7)*log(Z(7)) +Z(8)*log(Z(8)) +Z(7)*bet_a*muo_eo);
%---------------------------------------%
  EnLi_5= Z(9)*Z(8)*( bet_a*muo_eop-log(Z(9)*Z(8)+v_pair)+ 1 );
%---------------------------------------%
  EnLi_6= Z(9)* (Z(5)*muo_ha+Z(1)*muo_a );
%---------------------------------------%
  EnLi_7=  Z(4)*mu_a_menos+Z(3)*mu_h_mas+mu_h*Z(5)*Z(9);
%---------------------------------------%
  EnLi_8=  Z(2)*(Z(4)*q_a+Z(3)*q_h+Z(9)*Z(1)*q_a );

%------------------------------------------------------------------------------%
  EnLiTot=EnLi_1EnLi_2+EnLi_3+EnLi_4+EnLi_5+EnLi_6+EnLi_7+EnLi_8;
  F3=EnLiTot;
endfunction;
