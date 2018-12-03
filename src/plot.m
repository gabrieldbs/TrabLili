%path = '../../3D/bin/';
%Energia = load(strcat(path,'Ener_lib_1.txt'));
%% ACA MI IDEA ES ARMAR UN PROGRAMITA QUE PLOTEE
% EN PRINCIPIO EL ARCHIVO  VA A TENER 2*(KD_MAX+ABS(KD_MIN) )  COLUMNAS
% RHO_I ENER_I, POR HAY NO HACE FALTA GUARDAR TANTAS VECES RHO PERO POR LAS DUDAS EN PRINCIPIO LO GUARDO PARA CADA KD

Energia = load('Ener_lib.txt');
kdmin=0;
kdmax=5;
nrho=100; %nrho  esto seria la cantidad de puntos que va a haber en  cada tira de  rho energia 
%LA CANTIDAD DEPENDE DE LA CANTIDAD DE KD
color(1) = 'r';
color(2) = 'b';
color(3) = 'g';
color(4) = 'm';
color(5) = 'k';

%estos son los limites de kd 
kd=['kd1','kd2','kd3','KD4','kd5']
figure(1)
kdtot=kdmax+abs(kdmin);
for i=0:1:kdtot-1
  for j=1:1:nrho
    xlabel('rho_o');
    ylabel('Energy');
    hold all
    %Energia(i*(3)+j+1,2);
    plot(Energia(i*(nrho+1)+j+1,1),Energia(i*(nrho+1)+j+1,2),color(i+1))
    %legend(kd(3*0+1:3*0+3),kd(3*1+1:3*1+3),kd(3*2+1:3*2+3)) %% ESTO FALTA ARRREGLARLO LO QUE QUERIA ES METER LEGENDA EN KD
    hold all;
  end
end
print -dpng figure.png

%%POR COMO ESTOY PENSANDO EL ARCHIVO A CREAR VA A  TENER LA SIGUIENTE FORMA
%   'RHO'  'ENERGIA' %PARA KDMIN, ESTOS SON CARACTERES
%   RHO_MIN  ENERGIA(RHO_MIN)  %ESTOS SON VALORES
%   ...
%   ...
%   RHO_MAX  ENERGIA(RHO_MAX) % HASTA ACÁ SERÍAN NRHO VALORES
%   'RHO'  'ENERGIA' %PARA KDMIN+1, ESTOS SON CARACTERES
%   RHO_MIN  ENERGIA(RHO_MIN)  %ESTOS SON VALORES
%   ...
%   ...
%   RHO_MAX  ENERGIA(RHO_MAX) % HASTA ACÁ SERÍAN NRHO VALORES
%   ETC..
%%%%


