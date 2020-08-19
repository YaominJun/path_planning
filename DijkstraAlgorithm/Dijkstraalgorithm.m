clear;clc;
%载入地图
[xStart,yStart,xTarget,yTarget,MAP,MAX_X,MAX_Y]=LoadMap();
S(1).x=xStart;S(1).y=yStart;
S(1).father_x=xStart;S(1).father_y=yStart;
S(1).Q=0;
T=[];flag_find=0;i=1;n0=1;
MAP(xStart,yStart)=0;S1=[];
while flag_find==0
    %将地图中与S集相邻的空白点放入T集中
    [T,MAP]=GetNearSpaceNode(S,MAX_X,MAX_Y,MAP,T,i);
    %计算T集中每一个点到起始点的最短距离
    [T,MAP,flag_find,S1]=CalculateCost_in_T(T,MAP,xTarget,yTarget,flag_find,i,S,S1);
    %挑选T集中路径最短的点加入S集中
    [S,T,MAP,n,S1]=SelectMinnistCost_to_S(S,T,MAP,i,S1,n0,xTarget,yTarget);
    %检查是否已找到路径
    if flag_find~=0
        break;
    end
    n0=n0+n;
    i=i+1;
end
[vertex,XY,Qlest]=plotPath(flag_find,xTarget,yTarget,xStart,yStart,S,T);