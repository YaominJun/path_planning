function deta_f=PurePursuit2(L,x_v,y_v,y_G,l)
%Éè¶¨Ô¤Ãé¾àÀë
syms x
e1=solve(sqrt(L^2-(x-x_v)^2)+y_v-y_G(end)==0);e2=solve(-sqrt(L^2-(x-x_v)^2)+y_v-y_G(end)==0);e1=double(e1);e2=double(e2);
if e1
    xG=find(e1>0);
end
if e2
    xG=e2(find(e2>0));
end
xG=max(xG);
