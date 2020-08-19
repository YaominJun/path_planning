function [S,T,MAP,n,S1]=SelectMinnistCost_to_S(S,T,MAP,i,S1,n0,xTarget,yTarget)
n=length(S1);
for k=1:n
    S(k+n0).x=T(2*k-1);
    S(k+n0).y=T(2*k);
    S(k+n0).father_x=S(i).x;
    S(k+n0).father_y=S(i).y;
    S(k+n0).Q=S1(k);
    MAP(T(2*k-1),T(2*k))=0;
end

T=[];S1=[];