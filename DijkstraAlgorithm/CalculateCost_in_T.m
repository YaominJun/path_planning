function [T,MAP,flag_find,S1]=CalculateCost_in_T(T,MAP,xTarget,yTarget,flag_find,i,S,S1)
n=length(T);
for j=1:n/2
S1=[S1,S(i).Q+sqrt((T(2*j-1)-S(i).x)^2+(T(2*j)-S(i).y)^2)];
if T(2*j-1)==xTarget&&T(2*j)==yTarget
    flag_find=1;
end
end