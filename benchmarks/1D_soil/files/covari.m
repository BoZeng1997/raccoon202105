function [C,k,eta,eigva,eigve]=covari(X)%input the nodal var
% X=E0;
clear C;
Xm=mean(X,2);
m=size(X,1)
% compute covariance matrix
C = cov(X');
% Rnew = corrcoef(E0);
% for i=1:m
%     for j=1:m
%          C(i,j)=( (X(i,:)-Xm(i))*(X(j,:)-Xm(j))' )/199;
% % C(i,j)=((X(i,:)-Xm(i)).*(X(j)-Xm(j))+(X(i)-Xm(i)).*(X(j)-Xm(j))+...
% %     (X(i)-Xm(i)).*(X(j)-Xm(j))+(X(i)-Xm(i)).*(X(j)-Xm(j)));
%     end
% end
% solve for eigenvalues and sort them
[V,D]=eig(C);
[d,ind] = sort(diag(D),'descend');
eigva = D(ind,ind);
eigve = V(:,ind);
% eta=1;
k=0;
% clear eta;
% compute eta (which is not the primary now)
for k =1:m
    if eigva(k,k)>0
    eta(:,k)=((X-Xm)')*eigve(:,k)/sqrt(eigva(k,k))/2;
    else 
        break
    end
%     ks(end+1)=k;
%     end
end
end