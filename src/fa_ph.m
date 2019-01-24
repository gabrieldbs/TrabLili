
clear all;
      %----------------------%
      % ACA EMPIEZO ARMAR EL PROGRAMA QUE ITERE ELIB EN FUNCION RHO_O Y KD
      %-------------------------%
      % DEFINICIONES GLOBALES
%pkg load optim;


global bet_a
global kd
global ka
global rho_h_bulk
global rho_a_bulk    
global rho_o
global psi
global f_A
global f_ha
global f_hap
 

rho_o = 0.90 ;  % monomer concentration in film (M); ~ 1
vpair = 1.0 ;   % CHECKEAr
Temp=298;       % ------ K ------%
bet_a=96485/(Temp*8.3144);		% |e|/kT in V^-1

%kd=10^5;


%%-----------------ALGUNAS DEFINICIONES QUE VOY A USAR DENTRO DEL PROGRAMA--------------%%

epsi=10^(-5);
phmax=60;
paso=0.2;
for kdexp=1:1:1
  kd=10^(kdexp);
  kd=100;
  i=0;
  for iph=1:1:phmax
    ph=iph*paso;
    rho_h_bulk=10^(-ph);	
    rho_a_bulk=10^(-ph);
    rho_c_bulk=10^(-3);
    ka=10^(-5);		
    f_A = 0.5;		 %% initial conditions for solver
    psi = 0;		 %% initial conditions for solver
                %lbounds = [0 -inf];	 %% bounds of  f_A and psi
                %ubounds = [1 inf]; 	 %% bounds of  f_A and psi
    Xo=[f_A,psi];		 %% CONDICIONES INICIALES PARA EL FSOLV Xo=[f_a,ps_i]%   
                %options = optimset('Tolfun', 1E-12, 'TolX', 1e-12, 'MaxFunEvals', 10000);
  % Func = @(X) [X(1)*(1+rho_h_bulk*(exp(-bet_a*X(2)))/ka)+(kd/ka)*rho_o*X(1)*rho_h_bulk*(exp(-bet_a*X(2)))*(X(1)+X(1)*rho_h_bulk*(exp(-bet_a*X(2)))/ka)-1;rho_a_bulk*exp(bet_a*X(2))+rho_o*X(1)-rho_h_bulk*exp(-bet_a*X(2))];
    Func_corr = @(X) [X(1)*(1+((rho_h_bulk*(exp(-bet_a*X(2))))/ka)+(rho_o*rho_h_bulk*(exp(-bet_a*X(2)))*vpair/(ka*(kd+rho_o*vpair))))-1;rho_a_bulk*exp(bet_a*X(2))+rho_o*X(1)-rho_h_bulk*exp(-bet_a*X(2))-rho_c_bulk*exp(-bet_a*X(2))];
    %[X resnorm] = lsqnonlin(@myfun,Xo,lbounds,ubounds, options);
    [X,fval,info] = fsolve(Func_corr,Xo);
    if (info==1)
      %myfun(X);     
      %resnorm;	
      psi = X(2);
      f_A = X(1);
      f_ha = f_A*rho_h_bulk*(exp(-bet_a*psi))/ka;
      f_hap =1-f_A-f_ha;
      ph_a(iph)=ph;
      m(iph,kdexp)=[X(1)];  % to plot f_A vs ph
      n(iph,kdexp)=[f_ha];  % to plot f_ha vs ph
     % o(iph,kdexp)=[f_hap];  % to plot f_hap vs ph
      check(iph,kdexp)=[sqrt(Func_corr(X)(1)^2+Func_corr(X)(2)^2 )] ;
      r(iph,kdexp)=[X(2)];  % to plot  psi vs ph
      %fprintf(fid, '%f \t %f\n', m(1),m(2) );		
            %elseif (info==2)
             % [X,fval,info] = fsolve(Func,X);
             % ch=info;
              %myfun(X);     
              %resnorm;	
             % psi = X(2);
              %f_A = X(1);
             % f_ha = f_A*rho_h_bulk*(exp(-bet_a*psi))/ka;
             % f_hap =1-f_A-f_ha;
            %  ph_a(iph)=ph;
           %   m(iph,kdexp)=[X(1)];  % to plot f_A vs ph
          %    n(iph,kdexp)=[f_ha];  % to plot f_ha vs ph
             % o(iph,kdexp)=[f_hap];  % to plot f_hap vs ph
         %     check(iph,kdexp)=[sqrt(Func(X)(1)^2+Func(X)(2)^2 )] ;
        %      r(iph,kdexp)=[X(2)];  % to plot  psi vs ph
              %fprintf(fid, '%f \t %f\n', m(1),m(2) );		  
    else
      [X,fval,info] = fsolve(Func_corr,X);
      [X,fval,info] = fsolve(Func_corr,X);
      [X,fval,info] = fsolve(Func_corr,X);
      [X,fval,info] = fsolve(Func_corr,X);
      ch2=info;
      %myfun(X);     
      %resnorm;	
      psi = X(2);
      f_A = X(1);
      f_ha = f_A*rho_h_bulk*(exp(-bet_a*psi))/ka;
      f_hap =1-f_A-f_ha;
      ph_a(iph)=ph;
      m(iph,kdexp)=[X(1)];  % to plot f_A vs ph
      n(iph,kdexp)=[f_ha];  % to plot f_ha vs ph
     % o(iph,kdexp)=[f_hap];  % to plot f_hap vs ph
      check(iph,kdexp)=[sqrt(Func_corr(X)(1)^2+Func_corr(X)(2)^2 )] ;
      r(iph,kdexp)=[X(2)];  % to plot  psi vs ph
      %fprintf(fid, '%f \t %f\n', m(1),m(2) );		
     end
  end

   hold all;
  plot (ph_a(1,:),m(:,kdexp)',";f_{A};")
  %plot (ph_a(1,:),n(:,kdexp)',";f_{ha};")
  %plot (ph_a(1,:),o(:,kdexp)',";f_{hap};")
  %plot (ph_a(1,:),check(:,kdexp)',";check;")
  hold all;
end


%clear all

%fid = fopen('fa_ph.txt',"w");%aca no se si va w o s o sino va nada 
 %for kdexp=0:1:10
 %i=0;
 % for ph=0:paso:phmax
 %   i=i+1;
 %   fprintf(fid, '%f \t %f\n', ph,m(kdexp*(phmax/paso+1)+i) );
 % end
 %end
%fclose(fid);

%fide = fopen('psi_ph.txt',"w");%aca no se si va w o s o sino va nada 
 %for kdexp=0:1:10
 %i=0;
 % for ph=0:paso:phmax
  %  i=i+1;
   % fprintf(fide, '%f \t %f\n', ph,r(kdexp*(phmax/paso+1)+i) );
  %end
 %end
%fclose(fide);

%fidch = fopen('check_ph.txt',"w");%aca no se si va w o s o sino va nada 
% for kdexp=0:1:10
% i=0;
%  for ph=0:paso:phmax
 %   i=i+1;
 %   fprintf(fidch, '%f \t %f\n', ph,check(kdexp*(phmax/paso+1)+i) );
 % end
 %end
%fclose(fidch);

%%------------------funciones para fsolve--------------------%%%
%function  F = myfun(X)
    
%global bet_a
%global kd
%global ka
%global rho_h_bulk
%global rho_a_bulk    
%global rho_o

%X;

%F(1) = X(1)*(1+rho_h_bulk*(exp(-bet_a*X(2)))/ka)+(kd/ka)*rho_o*X(1)*rho_h_bulk*(exp(-bet_a*X(2)))*(X(1)+X(1)*rho_h_bulk*(exp(-bet_a*X(2)))/ka)-1;
%F(2) = rho_a_bulk*exp(bet_a*X(2))+rho_o*X(1)-rho_h_bulk*exp(-bet_a*X(2));

%end 
