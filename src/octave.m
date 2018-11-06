// Funciones octave

//1
function f_eo_p(f_ha_p)
	f_eo_p=f_ha_p;
endfunction

//2
function f_eo(f_ha_p)
	f_eo=1-f_ha_p;
endfunction

//3
function f_ha(f_hap,kd_o,rho_o)
	f_ha= f_hap/(kd_o*(1-fhap)*rho_o);
endfunction

//4
function f_a(ka_o,rho_h_mas,f_ha)
	f_a=ka_o *f_ha/rho_h_mas;
endfunction

//5

