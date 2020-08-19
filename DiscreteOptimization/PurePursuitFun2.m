function [x_path,y_path,deta]=PurePursuitFun2(L,l,V,t,x_G,y_G,x_v,y_v,theta)
%以预瞄距离L为变量跟踪直线段
%参考路径
%假定初始车头朝向与x轴平行
x_path=[];y_path=[];x_path=[x_path,x_v];y_path=[y_path,y_v];deta=[];i=1;
while i<=50/V && x_v<=x_G(end)
    [xG,yG]=PurePursuit(L,x_v,y_v,x_G,y_G);    
    deta_x=abs((tan(theta)*xG-yG-tan(theta)*(x_v)+y_v))/sqrt(tan(theta)^2+1);
    R=L^2/(2*deta_x);beta=V*t/R;
    %xG_L=(xG-x_v)*sin(theta)-(yG-y_v)*cos(theta);%求点到直线的距离公式分子  
    xG_L=tan(theta)*xG-yG-tan(theta)*x_v+y_v;
    deta_f=-sign(xG_L)*atan(l/R);
    deta=[deta,deta_f];
    if ~isinf(R)
        xLpath=sign(xG_L)*(R-R*cos(beta));  
        yLpath=R*sin(beta);
        x_v=x_v+xLpath*sin(theta)+yLpath*cos(theta);y_v=y_v-xLpath*cos(theta)+yLpath*sin(theta);        
        theta=theta-sign(xG_L)*beta;
        x_path=[x_path,x_v];y_path=[y_path,y_v];
    else
        xLpath=0;
        yLpath=V*t;
        x_v=x_v+xLpath*sin(theta)+yLpath*cos(theta);y_v=y_v-xLpath*cos(theta)+yLpath*sin(theta);        
        theta=theta-sign(xG_L)*beta;
        x_path=[x_path,x_v];y_path=[y_path,y_v];
    end    
    if x_path(end)<x_path(end-1)
        error('请检查车头初始航向角是否合理，要求朝向基准路径的前进方向')
    end
    i=i+1;
end
plot(x_path,y_path,'-*');