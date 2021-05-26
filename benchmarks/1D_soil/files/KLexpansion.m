[C_PE_E,k_PE_E,eta_PE_E,eigva_PE_E,eigve_PE_E]=covari(E0);
plot(1-cumsum(diag(eigva_PE_E))/sum(diag(eigva_PE_E)))
% C_E=C;
% k_E=k;
% eta_E=eta;
% eigva_E=eigva;
% eigve_E=eigve;
[C_PE_G,k_PE_G,eta_PE_G,eigva_PE_G,eigve_PE_G]=covari(G_PE);
plot(1-cumsum(diag(eigva_PE_G))/sum(diag(eigva_PE_G)))
xlim([0,100])
% C_G=C;
% k_G=k;
% eta_G=eta;
% eigva_G=eigva;
% eigve_G=eigve;
% [C_PE_d,k_PE_d,eta_PE_d,eigva_PE_d,eigve_PE_d]=covari(damage_PE);
% C_d=C;
% k_d=k;
% eta_d=eta;
% eigva_d=eigva;
% eigve_d=eigve;
clear err_PE_E
sum0=sum(diag(eigva_PE_E));
n=1
err_PE_E(1)=1-eigva_PE_E(1,1)/sum0;
for n=2:m
err_PE_E(n)=err_PE_E(n-1)-eigva_PE_E(n,n)/sum0;
end

sum0=sum(diag(eigva_PE_G));
n=1
err_PE_G(1)=1-eigva_PE_G(1,1)/sum0;
for n=2:m
err_PE_G(n)=err_PE_G(n-1)-eigva_PE_G(n,n)/sum0;
end

sum0=sum(diag(eigva_PE_d));
n=1
err_PE_d(1)=1-eigva_PE_d(1,1)/sum0;
for n=2:m
err_PE_d(n)=err_PE_d(n-1)-eigva_PE_d(n,n)/sum0;
end
plot(err_PE_E,'r--')
hold on
plot(err_PE_G,'k--')
plot(err_PE_d,'b--')
plot(err_PE_E,'r')
hold on
plot(err_PE_G,'k')
plot(err_PE_d,'b')
ylabel('error function')
xlabel('dimension')
title('err conv. L3P100-Gc-E-r0 10201node 100samp')
legend('PE-E','PE-G_c','PE-damage','PE-E','PE-G_c','PE-damage')