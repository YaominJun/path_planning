function [xG,yG]=PurePursuit(L,x_v,y_v,x_G,y_G)
%Éè¶¨Ô¤Ãé¾àÀë
xG1=find((y_G-y_v).^2+(x_G-x_v).^2-L^2>=0);
xG_location=xG1(find(x_G(xG1)>=x_v));
if xG_location
else
    xG_location=length(x_G);
end
xG=x_G(xG_location(1));
yG=y_G(xG_location(1));