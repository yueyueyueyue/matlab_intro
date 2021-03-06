function avgPower = turbineObjective(x)
%CALC_AVGPOWER
%    AVGPOWER = CALC_AVGPOWER(PER,C,K,U_C,U_F,U_R)

%    This function was generated by the Symbolic Math Toolbox version 5.3.
%    16-Feb-2010 11:14:56

Per = 2.4e6;
c = 12.5;
k = 2.2; 
u_c = x(1);
u_r = x(2);
u_f = x(3);

t2 = 1./c;
t3 = u_c.^k;
t4 = t2.*u_r;
t5 = t4.^k;
t6 = exp(-t5);
t7 = u_r.^k;
t8 = t3-t7;
t9 = t2.*u_c;
t10 = t9.^k;
t11 = exp(-t10);
t12 = c.^k;
avgPower = Per.*t6-Per.*exp(-(t2.*u_f).^k)+(Per.*t11.*t3)./t8-(Per.*t3.*t6)./t8-(Per.*t11.*t12.*(t10+1.0))./t8+(Per.*t12.*t6.*(t5+1.0))./t8;
avgPower = -avgPower;
