% @author: yaomin lu
% @file: Dijkstra Algorithm
% input: MAP, xStart, yStart, xTarget,yTarget
% CloseSet：Close Set闭集. 已访问过的已作为CurP的所有顶点集合，初始只含源点s。
    %(能够作为CurP从优先级队列中提取出来说明该顶点已经是代价最小的点了，再往前也没有比这更小的路径了)。
    %(这里的闭集和平常看的不一样的是，没有对里面的顶点进行代价更新，而是直接堆砌在数组后面，
    % 只是在plotPath中进行了处理，当存在相同顶点时，从其中找到最小代价的顶点提取出来即为路径)
% OpenSet：Open Set开集. 尚未作为CurP但已经被访问过的(作为邻接点)的所有顶点集合。
    %(用Heap最小堆/优先级队列进行表示。存储的是亟待被提取的顶点: @UpdateOpenSet
    % 这里面有顶点代价更新)
% T: 每一层可以访问的顶点集合
    %(用来获取邻接点: @GetNearSpaceNode)
% Dist：距离矩阵，初始化为inf无穷大
    %(从起点到点(x,y)的当前最小距离，即存放G_cost的集合)
% output: result_path(最终路径)

clear;clc;
filename = 'E:\6github\path_planning\Search_based_Planning\DijkstraAlgorithm\result.gif';
heap = heapFuns;
%载入地图
[xStart,yStart,xTarget,yTarget,MAP,MAX_X,MAX_Y]=LoadMap();
Dist = inf*ones(size(MAP)); Visited = zeros(size(MAP));
Dist(xStart,yStart)=0; Visited(xStart,yStart)=1;
V.x = xStart; V.y=yStart; V.father_x=xStart;V.father_y=yStart;
if MAP(xStart, yStart) == 0
    fprintf('WARN: 起点是障碍物区域!!!没有找到路径!!! 失败!!!\n');
    return;
end
V.Q=CalculateGCost(V.x,V.y,V,Dist); 
OpenSet(1) = V;
T=[];
count=1; flag_find=0;
while flag_find==0
    [~, c] = size(OpenSet);
    if c < 1
        break;%队列为空；搜索失败
    end
    %挑选OpenSet开集(Heap)中路径最短的点加入CloseSet闭集(数组)中
    [OpenSet, CurP] = heap.popHeap(OpenSet);
    CloseSet(count) = CurP;
    %检查是否已找到路径
    if CurP.x==xTarget&&CurP.y==yTarget
        flag_find=1; %找到目标点；搜索成功
        break;
    end
    %将地图中与CurP相邻的无碰撞的邻接点放入T集中
    T=GetNearSpaceNode(MAX_X,MAX_Y,MAP,CurP);
    %将CurP的邻接点加入OpenSet开集(Heap)中
    %Dijkstra set the cost as the priority 
    [Dist,OpenSet,Visited]=UpdateOpenSet(T,CurP,Dist,xTarget,yTarget,OpenSet,heap,Visited);
    count = count + 1;
end
%绘制路径
if flag_find
    [vertex,XY]=plotPath(xTarget,yTarget,CloseSet,filename,false);
    %最终路径结果
    result_path = zeros(2, length(vertex));
    for i = 1:length(vertex)
        result_path(1,i) = XY(1,vertex(length(vertex)-i+1));
        result_path(2,i) = XY(2,vertex(length(vertex)-i+1));
    end
else
    fprintf('WARN: 终点是障碍物区域!!!没有找到路径!!! 失败!!!\n');
end