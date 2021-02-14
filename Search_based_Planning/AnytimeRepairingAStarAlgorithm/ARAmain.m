% @author: yaomin lu
% @file: Anytime Repairing A Star Algorithm
% input: MAP, xStart, yStart, xTarget,yTarget
% CloseSet：Close Set闭集. 已访问过的已作为CurP的所有顶点集合，初始只含源点s。
    %(能够作为CurP从优先级队列中提取出来说明该顶点已经是代价最小的点了，再往前也没有比这更小的路径了)。
    %(这里的闭集和平常看的不一样的是，没有对里面的顶点进行代价更新，而是直接堆砌在数组后面，
    % 只是在plotPath中进行了处理，当存在相同顶点时，从其中找到最小代价的顶点提取出来即为路径)
    % 存放已经扩展过的状态的列表。此列表中v值等于g值，为一致（consistent）状态。
% OpenSet：Open Set开集. 尚未作为CurP但已经被访问过的(作为邻接点)的所有顶点集合。
    %(用Heap最小堆/优先级队列进行表示。存储的是亟待被提取的顶点: @UpdateOpenSet
    % 这里面有顶点代价更新)
    % 存放不一致性（inconsistent）状态的列表，当不在CLOSED列表的状态被计算降低g值时，放入open表中。
    % 表中根据状态的key()值进行排序，最小的在最上面。
% INCONS：inconsistent集合. 当属于CLOSED的状态又被降低g值时，放入此表中；存放在此表的状态仍然为inconsistent状态。
    %若一个状态s的v(s)不等于g(s), 则称为inconsistent 。
    %放入open列表的状态均是inconsistent状态，但是inconsisitent状态不一定在open列表中。
    
% T: 每一层可以访问的顶点集合
    %(用来获取邻接点: @GetNearSpaceNode)
% Dist：距离矩阵，初始化为inf无穷大
    %(从起点到点(x,y)的当前最小距离，即存放G_cost的集合)
% output: result_path(最终路径)

clear;clc;
filename = 'E:\6github\path_planning\Search_based_Planning\AStarAlgorithm\result.gif';
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
V.Q=CalculateGCost(V.x,V.y,V,Dist)+CalculateHCost(V.x, V.y, xTarget,yTarget); 
OpenSet(1) = V; InconsSet(1) = V;
count=1; flag_find=0;
e = 2.5;

while update_e(OpenSet, InconsSet)
    e = e-0.4;
    
end