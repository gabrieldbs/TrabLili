%path = '../../3D/bin/';
%Energia = load(strcat(path,'Ener_lib_1.txt'));

Energia = load(strcat('Ener_lib_1.txt'));
figure(1)
plot(Ener_lib_1(:,2),Ener_lib_1(:,3))
xlabel('rho_o')
ylabel('Energy')
