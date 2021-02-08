%%%%%%%%%% ELEMENT STIFFNESS MATRIX of k-th laminate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% theta_k = �ngulo entre a dire��o principal e a dire��o global. 
%E1_rig e E2_rig s�o os valores de Young longitudinal e transversal do material r�gido
%os nu�s s�o os valores de Poisson do material r�gido
function [KE]=KEortotransv2(E1, E2, nu_12, nu_21, G12, t, theta_k)
a_ = 0.5; % a_ (temporariamente com underscore para diferenciar do 'a' usado no inicio a = E_1/E_2)
b = 0.5; % a_ e b se referem � metade do lado do elemento finito de lado de 1 unidade

% Matriz de rigidez reduzida Q
Q(1,1) = E1/(1-nu_12*nu_21) ;
Q(1,2) = nu_21*E1/(1-nu_12*nu_21);
Q(2,1) = Q(1,2);
Q(2,2) = E2/(1-nu_12*nu_21);
Q(3,3) = G12;

% Matriz de transforma��o T
theta_k = deg2rad(theta_k);
c = cos(theta_k);
s = sin(theta_k);
T_k = [c^2     s^2      s*c
       s^2     c^2      -s*c
       -2*s*c  2*s*c  c^2-s^2];

% Matriz de rigidez reduzida transformada Q_bar
Q_bar = T_k' * Q * T_k;

% Matriz A
A = t.*Q_bar;

% Matriz de rigidez KE de um elemento
KE(1,1)=(1./6.)*((2.*b*A(1,1)/a_)+3.*A(3,1)+(2.*a_*A(3,3)/b));
KE(1,2)=(1./12.)*(3.*A(1,2)+(4.*b*A(3,1)/a_)+(4.*a_*A(3,2)/b)+3.*A(3,3));
KE(1,3)=(-b*A(1,1))/(3.*a_)+(a_*A(3,3))/(6.*b);
KE(1,4)=(1./12.)*(3.*A(1,2)-(4.*b*A(3,1)/a_)+(2.*a_*A(3,2)/b)-3.*A(3,3));
KE(1,5)=(-1./6.)*((b*A(1,1)/a_)+3.*A(3,1)+(a_*A(3,3)/b));
KE(1,6)=(-1./12.)*(3.*A(1,2)+(2.*b*A(3,1)/a_)+(2.*a_*A(3,2)/b)+3.*A(3,3));
KE(1,7)=(b*A(1,1))/(6.*a_)-(a_*A(3,3))/(3*b);
KE(1,8)=(1./12.)*(-3.*A(1,2)+(2.*b*A(3,1)/a_)-(4.*a_*A(3,2)/b)+3.*A(3,3));

KE(2,1)=KE(1,2);
KE(2,2)=(1./6.)*((2.*a_*A(2,2)/b)+3.*A(3,2)+(2.*b*A(3,3)/a_));
KE(2,3)=(1./12.)*(-3.*A(1,2)-(4.*b*A(3,1)/a_)+(2.*a_*A(3,2)/b)+3.*A(3,3)); 
KE(2,4)=(a_*A(2,2))/(6.*b)-(b*A(3,3))/(3.*a_);
KE(2,5)=(-1./12.)*(3.*A(1,2)+(2.*b*A(3,1)/a_)+(2.*a_*A(3,2)/b)+3.*A(3,3));
KE(2,6)=(-1./6.)*((a_*A(2,2)/b)+3.*A(3,2)+(b*A(3,3)/a_));
KE(2,7)=(1./12.)*(3.*A(1,2)+(2.*b*A(3,1)/a_)-(4.*a_*A(3,2)/b)-3.*A(3,3));
KE(2,8)=(-a_*A(2,2))/(3.*b)+(b*A(3,3))/(6.*a_);

KE(3,1)=KE(1,3);
KE(3,2)=KE(2,3);
KE(3,3)=(1./6.)*((2.*b*A(1,1)/a_)-3.*A(3,1)+(2.*a_*A(3,3)/b));
KE(3,4)=(1./12.)*(-3.*A(1,2)+(4.*b*A(3,1)/a_)+(4.*a_*A(3,2)/b)-3.*A(3,3));
KE(3,5)=(b*A(1,1))/(6.*a_)-(a_*A(3,3))/(3.*b);
KE(3,6)=(1./12.)*(3.*A(1,2)+(2.*b*A(3,1)/a_)-(4.*a_*A(3,2)/b)-3.*A(3,3));
KE(3,7)=(1./6.)*((-b*A(1,1)/a_)+3.*A(3,1)-(a_*A(3,3)/b));
KE(3,8)=(1./12.)*(3.*A(1,2)-(2.*b*A(3,1)/a_)-(2.*a_*A(3,2)/b)+3.*A(3,3));

KE(4,1)=KE(1,4);
KE(4,2)=KE(2,4);
KE(4,3)=KE(3,4);
KE(4,4)=(1./6.)*((2.*a_*A(2,2)/b)-3.*A(3,2)+(2.*b*A(3,3)/a_));
KE(4,5)=(1./12.)*(-3.*A(1,2)+(2.*b*A(3,1)/a_)-(4.*a_*A(3,2)/b)+3.*A(3,3));
KE(4,6)=(-a_*A(2,2))/(3.*b)+(b*A(3,3))/(6.*a_);
KE(4,7)=(1./12.)*(3.*A(1,2)-(2.*b*A(3,1)/a_)-(2.*a_*A(3,2)/b)+3.*A(3,3));
KE(4,8)=(1./6.)*(-(a_*A(2,2)/b)+3.*A(3,2)-(b*A(3,3)/a_));

KE(5,1)=KE(1,5);
KE(5,2)=KE(2,5);
KE(5,3)=KE(3,5);
KE(5,4)=KE(4,5);
KE(5,5)=(1./6.)*((2.*b*A(1,1)/a_)+3.*A(3,1)+(2.*a_*A(3,3)/b));
KE(5,6)=(1./12.)*(3.*A(1,2)+(4.*b*A(3,1)/a_)+(4.*a_*A(3,2)/b)+3.*A(3,3));
KE(5,7)=(-b*A(1,1))/(3.*a_)+(a_*A(3,3))/(6.*b);
KE(5,8)=(1./12.)*(3.*A(1,2)-(4.*b*A(3,1)/a_)+(2.*a_*A(3,2)/b)-3.*A(3,3));

KE(6,1)=KE(1,6);
KE(6,2)=KE(2,6);
KE(6,3)=KE(3,6);
KE(6,4)=KE(4,6);
KE(6,5)=KE(5,6);
KE(6,6)=(1./6.)*((2.*a_*A(2,2)/b)+3.*A(3,2)+(2.*b*A(3,3)/a_));
KE(6,7)=(1./12.)*(-3.*A(1,2)-(4.*b*A(3,1)/a_)+(2.*a_*A(3,2)/b)+3.*A(3,3));
KE(6,8)=(a_*A(2,2))/(6.*b)-(b*A(3,3))/(3.*a_);

KE(7,1)=KE(1,7);
KE(7,2)=KE(2,7);
KE(7,3)=KE(3,7);
KE(7,4)=KE(4,7);
KE(7,5)=KE(5,7);
KE(7,6)=KE(6,7);
KE(7,7)=(1./6.)*((2.*b*A(1,1)/a_)-3.*A(3,1)+(2.*a_*A(3,3)/b));
KE(7,8)=(1./12.)*(-3.*A(1,2)+(4.*b*A(3,1)/a_)+(4.*a_*A(3,2)/b)-3.*A(3,3));

KE(8,1)=KE(1,8);
KE(8,2)=KE(2,8);
KE(8,3)=KE(3,8);
KE(8,4)=KE(4,8);
KE(8,5)=KE(5,8);
KE(8,6)=KE(6,8);
KE(8,7)=KE(7,8);
KE(8,8)=(1./6.)*((2.*a_*A(2,2)/b)-3.*A(3,2)+(2.*b*A(3,3)/a_));