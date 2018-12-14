pkg load optim
function  F = myfun(X)

pkg load optim 
global bet_a
global kd
global ka
global rho_h_bulk
global rho_a_bulk    
global rho_o

X;

F(1) = X(1)*(1+rho_h_bulk*(exp(-bet_a*X(2)))/ka)+(kd/ka)*rho_o*X(1)*rho_h_bulk*(exp(-bet_a*X(2)))*(X(1)+X(1)*rho_h_bulk*(exp(-bet_a*X(2)))/ka)-1;
F(2) = rho_a_bulk*exp(bet_a*X(2))+rho_o*X(1)-rho_h_bulk*exp(-bet_a*X(2));

end 
