%path = '../../3D/bin/';
%Energia = load(strcat(path,'Ener_lib_1.txt'));
for i=1:kmax
  Energia = load(strcat('Ener_lib_%d.txt','i'));
  figure(1)
  hold on
  plot(Ener_lib_1(:,2),Ener_lib_1(:,3))
  xlabel('rho_o');
  ylabel('Energy');
end
hold off
