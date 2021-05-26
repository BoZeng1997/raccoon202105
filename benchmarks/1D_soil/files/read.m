num_trials = 49999;
nodes=201;
E_PE = [];
G_PE=[];
damage_PE=[];
filename0 = '/1D_PE_L10P100_Gc_E_r0_N50_cluster_set';%
for i = 0:num_trials
    data = dlmread(['.',filename0,num2str(i,'%05.f'),filename0,num2str(i,'%05.f'),'_timestep101.dat'],' ',[1 3 nodes 3]);
    E_PE = [E_PE,data];
    data = dlmread(['.',filename0,num2str(i,'%05.f'),filename0,num2str(i,'%05.f'),'_timestep101.dat'],' ',[1 2 nodes 2]);
    G_PE = [G_PE,data];
    data = dlmread(['.',filename0,num2str(i,'%05.f'),filename0,num2str(i,'%05.f'),'_timestep101.dat'],' ',[1 1 nodes 1]);
    damage_PE = [damage_PE,data];
    
end
mean0=4;
cv=0.03;
std0=cv*mean0;
var=std0^2;
theta=var/mean0;
k=mean0/theta;
E0=norminv(gamcdf(E_PE,k,theta),0,1);
mean1=8e-4;
std1=cv*mean1;
var1=std0^2;
theta1=var1/mean1;
k1=mean1/theta1;
G0=norminv(gamcdf(G_PE,k1,theta1),0,1);
[C_PE_E,k_PE_E,eta_PE_E,eigva_PE_E,eigve_PE_E]=covari(E0);
cond(C_PE_E)
% for i =1:200%[1:35,37:48,50:90]
%     me_200(i)=mean(mean(G_PE_200(:,1:i)));
% end
% figure
% plot(me_200)
% for i =1:200%[1:35,37:48,50:90]
%     temp=G_PE_200(:,1:i);
%     stde_200(i)=std(temp(:));
% end
% figure
% plot(stde_200)
% % pd_12 = makedist('Gamma','a',k,'b',theta);
% % cdf_12 = cdf(pd_12,E_PE);
% % E0=norminv(cdf_12,0,1);