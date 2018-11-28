%path = '../../3D/bin/';
%Energia = load(strcat(path,'Ener_lib_1.txt'));
%% ACA MI IDEA ES ARMAR UN PROGRAMITA QUE PLOTEE
% EN PRINCIPIO EL ARCHIVO  VA A TENER 2*(KD_MAX+ABS(KD_MIN) )  COLUMNAS
% RHO_I ENER_I, POR HAY NO HACE FALTA GUARDAR TANTAS VECES RHO PERO POR LAS DUDAS EN PRINCIPIO LO GUARDO PARA CADA KD

Energia = load('Ener_lib.txt');
kd_min=-5;
kd_max=10;
%estos son los limites de kd 
kd=['kd1','kd2','kd3']
figure(1)
for i=0:1:kd_max+abs(kd_min)        %% tengo pensado correr un for para el plo
  xlabel('rho_o');
  ylabel('Energy');
  plot(Energia(:,i*2+1),Energia(:,i*2+2) ); 
  legend(kd(3*0+1:3*0+3),kd(3*1+1:3*1+3),kd(3*2+1:3*2+3)) %% ESTO FALTA ARRREGLARLO LO QUE QUERIA ES METER LEGENDA EN KD
  hold all;
end
print -dpng figure.png

%aca la idea era armar muchos archivos me parece que no es conveniente
%for i=1:kmax
%  Energia = load(strcat('Ener_lib_%d.txt','i'));
% figure(1)
% hold on
% plot(Ener_lib_1(:,2),Ener_lib_1(:,3))
%  xlabel('rho_o');
%  ylabel('Energy');
%end


