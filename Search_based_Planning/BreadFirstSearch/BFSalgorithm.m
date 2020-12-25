% @author: yaomin lu
% @file: BFS, bread first search
% input: MAP, xStart, yStart, xTarget,yTarget
% S：已访问过的顶点集合，初始只含源点s；不会有重复，因为Visited保证只能一次访问
% T: 每一层可以访问的顶点集合
    %(用来获取邻接点: @GetNearSpaceNode)
% Visited：访问图
% output: result_path(最终路径)

clear;clc;
filename = 'E:\6github\path_planning\Search_based_Planning\BreadFirstSearch\result.gif';
queue = queueFuns;
%载入地图
[xStart,yStart,xTarget,yTarget,MAP,MAX_X,MAX_Y]=LoadMap();
S(1).x=xStart;S(1).y=yStart;
S(1).father_x=xStart;S(1).father_y=yStart;
Visited = zeros(size(MAP)); Queue = [];
T=[];flag_find=0;n0=1;
MAP(xStart,yStart)=0; Visited(xStart,yStart)=1; Queue = [Queue, S(1)];
while flag_find==0
    [~, c] = size(Queue);
    if c < 1
        break;%队列为空
    end
    [Queue, CurP] = queue.deQueue(Queue);
    %将地图中与S集第i个点（出队列）相邻的空白点放入T集中
    T=GetNearSpaceNode(MAX_X,MAX_Y,MAP,CurP);
    %挑选T集中没有访问过的点加入S集中（入队列）
    %BFS add the new visited node in the end of the openset
    [S,n, Visited, flag_find,Queue]=SelectNonVisited_to_S(S,T,CurP,n0,Visited, flag_find, xTarget,yTarget,Queue,queue);
    %检查是否已找到路径
    if flag_find~=0
        break;
    end
    n0=n0+n;
end
%绘制路径
if flag_find
    [vertex,XY]=plotPath(xTarget,yTarget,S,filename,true);
    %最终路径结果
    result_path = zeros(2, length(vertex));
    for i = 1:length(vertex)
        result_path(1,i) = XY(1,vertex(length(vertex)-i+1));
        result_path(2,i) = XY(2,vertex(length(vertex)-i+1));
    end
else
    fprintf('WARN: 终点是障碍物区域!!!没有找到路径!!! 失败!!!\n');
end