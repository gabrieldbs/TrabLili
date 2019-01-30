clear all;

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
  
%% NOTAS
% El programa va abrir 4 .txt  con:
%f_a vs. ph, un txt para ka=10^-1 y otro para ka = 10^-5
% pka aparente vs log10(kd), un txt para ka=10^-1 y otro para ka = 10^-5


rho_o = 0.99 ;  % monomer concentration in film (M); ~ 1
vpair = 1.0 ;   % CHECKEAR
Temp=298;       % ------ K ------%
bet_a=96485/(Temp*8.3144);		% |e|/kT in V^-1

phmax=140;
paso=0.1;
kdleg=0;
labels = {};
citermax=3;
kdmax=7;

for j=1:1:2         % 2 values of ka --> (-1),(-5)
  ka=10^(-((j-1)*4+1));    
    for citer=1:1:citermax % 3 values of csalt --> (-1),(-2),(-3)
        rho_c_bulk=10^(-citer);
        Csalt(citer)=10^(-citer);
        for kdexp=1:1:kdmax  % 8 values of  kd --> [0,7]
          kd=10^((kdexp));
          kdleg(kdexp)=10^((kdexp));
          i=0;
          for iph=1:1:phmax %% ph from 0 to 14 with 0.1
            %%%%%%%%---------%%%%%%
            %%%%%%% This part solve the system
              
            ph=iph*paso;
            rho_h_bulk=10^(-ph);	
            rho_a_bulk=10^(-ph);
            %rho_c_bulk=10^(-3);
            %ka=10^(-5);		
            f_A = 0.5;		 %% initial conditions for solver
            psi = 0;		   %% initial conditions for solver
                                       %lbounds = [0 -inf];	 %% bounds of  f_A and psi
                                       %ubounds = [1 inf]; 	 %% bounds of  f_A and psi
            Xo=[f_A,psi];	 %% CONDICIONES INICIALES PARA EL FSOLV Xo=[f_a,ps_i]%   
                           %options = optimset('Tolfun', 1E-12, 'TolX', 1e-12, 'MaxFunEvals', 10000);
                           % Func = @(X) [X(1)*(1+rho_h_bulk*(exp(-bet_a*X(2)))/ka)+(kd/ka)*rho_o*X(1)*rho_h_bulk*(exp(-bet_a*X(2)))*(X(1)+X(1)*rho_h_bulk*(exp(-bet_a*X(2)))/ka)-1;rho_a_bulk*exp(bet_a*X(2))+rho_o*X(1)-rho_h_bulk*exp(-bet_a*X(2))];
                           %  Func_corr = @(X) [rho_o*vpair*X(1)*X(1)*(1+rho_h_bulk*(exp(-bet_a*X(2)))/ka)*rho_h_bulk*(exp(-bet_a*X(2)))-ka*kd*(1-X(1)-X(1)*rho_h_bulk*(exp(-bet_a*X(2)))/ka);rho_a_bulk*exp(bet_a*X(2))+rho_o*X(1)-rho_h_bulk*exp(-bet_a*X(2))-rho_c_bulk*exp(-bet_a*X(2))];
            Func_corr = @(X) [X(1)*(1+rho_h_bulk*(exp(-bet_a*X(2)))/ka)+X(1)*X(1)*(kd*vpair*rho_o/ka)*rho_h_bulk*(exp(-bet_a*X(2)))*(1+rho_h_bulk*(exp(-bet_a*X(2)))/ka)-1;rho_a_bulk*exp(bet_a*X(2))+rho_o*X(1)-rho_h_bulk*exp(-bet_a*X(2))-rho_c_bulk*exp(-bet_a*X(2))];
                           %[X resnorm] = lsqnonlin(@myfun,Xo,lbounds,ubounds, options);
            [X,fval,info] = fsolve(Func_corr,Xo);  %INFO == 1 ==> CONVERGE;
           
          %%ESTO ES POR LO DEL TEMA DE CONVERGNECIA%% 
            if (info==1)
              psi = X(2);
              f_A = X(1);
                          %f_ha = f_A*rho_h_bulk*(exp(-bet_a*psi))/ka;
                          %f_hap =1-f_A-f_ha;
              ph_a(iph)=ph;
              m(iph,kdexp,citer)=[X(1)];  % to plot f_A vs ph
                          %n(iph,kdexp)=[f_ha];  % to plot f_ha vs ph
                          %o(iph,kdexp)=[f_hap];  % to plot f_hap vs ph
                          %check(iph,kdexp)=[sqrt(Func_corr(X)(1)^2+Func_corr(X)(2)^2 )] ;
                          %r(iph,kdexp)=[X(2)];  % to plot  psi vs ph
                          
                            
            else
              [X,fval,info] = fsolve(Func_corr,X);
              [X,fval,info] = fsolve(Func_corr,X);
              [X,fval,info] = fsolve(Func_corr,X);
              ch2=info;
              psi = X(2);
              f_A = X(1);
              f_ha = f_A*rho_h_bulk*(exp(-bet_a*psi))/ka;
              f_hap =1-f_A-f_ha;
              ph_a(iph)=ph;
              m(iph,kdexp,citer)=[X(1)];  % to plot f_A vs ph
                                                       %n(iph,kdexp)=[f_ha];  % to plot f_ha vs ph
                                                       %o(iph,kdexp)=[f_hap];  % to plot f_hap vs ph
                                                       %check(iph,kdexp)=[sqrt(Func_corr(X)(1)^2+Func_corr(X)(2)^2 )] ;
                                                       %r(iph,kdexp)=[X(2)];  % to plot  psi vs ph
             end % END OF IF/ELSE  (CONVERGENCE)
             
          end %END OF PH ITER
         
          %%%%%%%----------%%%%%%%%%5
          
          %%%%%%%%%-----------------%%%%%%%%%%%
          %%%% This part calculate the point of interpolation fa=0.5  and plot fa vs ph. remember that vector m is fa
                                          %[calc_fa_05,i]=min (abs(m(:,kdexp)-0.5)) ; %This have to calculate the nearest value of  f_a to 0.5. The output have first the value of f_a and then the position on the  vector 
                                          %pph(kdexp)=i*0.1  % with the position it's calculate the ph, for each kd,  with f_a near to 0.5
          pphs(kdexp,citer)= interp1 ( m(:,kdexp,citer),ph_a(:), 0.5,"spline"); % INTERPOLATE F_A =0.5 THE OUTPUT IS PH
        
       %% Esta parte es para graficar  fa vs  ph
          if (j==1)
            figure (1)
            hold all;
            h=plot (ph_a(1,:),m(:,kdexp,citer)');  % PLOT PH VS F_A
            y=plot (pphs(citer),0.5,"color", "m");  % PLOT THE POINT WITH f_A =0.5
            legend (cellstr (num2str (kdleg')), "location", "northwest");hold on;
            hold all;
           else
            figure (2)
            hold all;
            h=plot (ph_a(1,:),m(:,kdexp,citer)');  % PLOT PH VS F_A
            y=plot (pphs(citer),0.5,"color", "m");  % PLOT THE POINT WITH f_A =0.5
            legend (cellstr (num2str (kdleg')), "location", "northwest");hold on;
             hold all;
           end
       %% esta pare es para graficar fa vs ph   
        end % END OF KDEXP
     
      %%%%%%%%%-----------------%%%%%%%%%%%
        %% THIS PART  CALCULATE  PKA APARENTE VS LOG10(KD)  AND PRINT
      if (j==1)
          figure(3)
          hold all;
          title('ka=10^{-1}');
          xlabel('log10 (kd)');
          ylabel('pKa aparente');
          l=plot(log10(kdleg),pphs(:,citer),'o');   %This is the plot of pKa aparente vs. log10 (Kd)
          labels = {labels{:}, ["Csalt 10^-", num2str(citer)]};
          legend (labels, "location", "northwest");hold on;
          
     
      else
          figure(4)
          hold all;
          title('ka=10^{-5}');
          xlabel('log10 (kd)');
          ylabel('pKa aparente');
         l=plot(log10(kdleg),pphs(:,citer),'o');   %This is the plot of pKa aparente vs. log10 (Kd)
         labels = {labels{:}, ["Csalt 10^-", num2str(citer)]};
         legend (labels, "location", "northwest");hold on;
          
      end % if del final plot
      %%%%%%%%%-----------------%%%%%%%%%%%
      
    end % for citer
    %% THIS IS FOR fprintf in txt the results
    if(j==1)
      %% first  pka aparente vs log kd
      fid = fopen('pka_aparente_ka_1',"w");
         fprintf(fid,'log (kd) \t pka aparente con ka= 10^-1 \n');
         for q=1:1:citermax
              fprintf(fid,' Csalt = 10^-%f \n',q);
             for k=1:1:kdmax
              fprintf(fid, '%f \t %f \n',log10(kdleg(k))',pphs(k,q));
             end
         end
      fclose(fid);
      %% then fa vs ph 
      fidd = fopen ('fa_ph_ka_1',"w");
         fprintf(fidd,'ph \t fa con ka= 10^-1 \n');
         for q=1:1:citermax
              fprintf(fidd,' Csalt = 10^-%f \n',q);
             for k=1:1:kdmax
                 fprintf(fidd,' kd = 10^-%f \n',k);
                 for iiph=1:1:phmax
                  fprintf(fidd, '%f \t %f \n',ph_a(iiph),m(iiph,k,q));
                  end
             end
         end
      fclose (fidd);
      
    else
      % first pka aparente vs kd
       fide = fopen('pka_aparente_ka_5',"w"); 
         fprintf(fide,'log (kd) \t pka aparente con ka= 10^-5\n');
         for q=1:1:citermax
            fprintf(fide,' Csalt = 10^-%f \n',q);
            for k=1:1:kdmax
              fprintf(fide, '%f \t %f \n',log10(kdleg(k))',pphs(k,q));
            end
         end
       fclose(fide);
       
       %% then fa vs ph 
      fidde = fopen ('fa_ph_ka_5',"w");
         fprintf(fidde,'ph \t fa con ka= 10^-5 \n');
         for q=1:1:citermax
              fprintf(fidde,' Csalt = 10^-%f \n',q);
             for k=1:1:kdmax
                 fprintf(fidde,' kd = 10^-%f \n',k);
                 for iiph=1:1:phmax
                  fprintf(fidde, '%f \t %f \n',ph_a(iiph),m(iiph,k,q));
                  end
             end
         end
      fclose (fidde);
      
    end %if else del txt
end % for ka

%%%%%%%%%%%%%%%%%
%% NOTAS:
%%%%%%%%%%%%%%%%%
% BARRIDA EN KD   DE 0;7 EN EL EXPONENTE OK
% BARRIDA EN CSALT  DE -1;-3 EN EL EXPONENTE OK 
% BARRIDA EN KA  OK
% SACAR ARCHIVO TXT  


%%%%-----------------------------------lo que viene atras de aca es posible que se pueda tirar pero puede que use alguna que otra cosa %%%%%%%%%%%
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
