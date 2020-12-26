% @author: yaomin lu
% @file: Bidirectional A Star Algorithm
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
filename = 'E:\6github\path_planning\Search_based_Planning\BidirectionalAStarAlgorithm\result.gif';
heap = heapFuns;
%载入地图
[xStart,yStart,xTarget,yTarget,MAP,MAX_X,MAX_Y]=LoadMap();

%方向一：从起点Start出发
Dist_fore = inf*ones(size(MAP)); Visited_fore = zeros(size(MAP));
Dist_fore(xStart,yStart)=0; Visited_fore(xStart,yStart)=1;
V_fore.x = xStart; V_fore.y=yStart; V_fore.father_x=xStart;V_fore.father_y=yStart;
if MAP(xStart, yStart) == 0
    fprintf('WARN: 起点是障碍物区域!!!没有找到路径!!! 失败!!!\n');
    return;
end
V_fore.Q=CalculateGCost(V_fore.x,V_fore.y,V_fore,Dist_fore)+CalculateHCost(V_fore.x, V_fore.y, xTarget,yTarget); 
OpenSet_fore(1) = V_fore;

%方向二：从终点Goal出发
Dist_back = inf*ones(size(MAP)); Visited_back = zeros(size(MAP));
Dist_back(xTarget,yTarget)=0; Visited_back(xTarget,yTarget)=1;
V_back.x = xTarget; V_back.y=yTarget; V_back.father_x=xTarget;V_back.father_y=yTarget;
if MAP(xTarget, yTarget) == 0
    fprintf('WARN: 终点是障碍物区域!!!没有找到路径!!! 失败!!!\n');
    return;
end
V_back.Q=CalculateGCost(V_back.x,V_back.y,V_back,Dist_back)+CalculateHCost(V_back.x, V_back.y, xStart,yStart); 
OpenSet_back(1) = V_back;

T_fore=[]; T_back=[];
count=1; flag_find=0;
V_meet = V_fore;
while flag_find==0
    [~, c_fore] = size(OpenSet_fore); [~, c_back] = size(OpenSet_back);
    if c_fore < 1 || c_back < 1
        break;%队列为空；搜索失败
    end
    if c_fore >= 1 
        %挑选OpenSet开集(Heap)中路径最短的点加入CloseSet闭集(数组)中
        [OpenSet_fore, CurP_fore] = heap.popHeap(OpenSet_fore);
        CloseSet_fore(count) = CurP_fore;
        %检查是否已找到路径
        if count > 1 && inSet(CurP_fore,CloseSet_back)%避免报CloseSet_back未定义的错误
            V_meet = CurP_fore;
            flag_find=1; %找到目标点；搜索成功
            break;
        end
        %将地图中与CurP相邻的无碰撞的邻接点放入T集中
        T_fore=GetNearSpaceNode(MAX_X,MAX_Y,MAP,CurP_fore);
        %将CurP的邻接点加入OpenSet开集(Heap)中
        %Dijkstra set the cost as the priority 
        [Dist_fore,OpenSet_fore,Visited_fore]=UpdateOpenSet(T_fore,CurP_fore,Dist_fore,xTarget,yTarget,OpenSet_fore,heap,Visited_fore); 
    end
    if c_back >= 1
        %挑选OpenSet开集(Heap)中路径最短的点加入CloseSet闭集(数组)中
        [OpenSet_back, CurP_back] = heap.popHeap(OpenSet_back);
        CloseSet_back(count) = CurP_back;
        %检查是否已找到路径
        if inSet(CurP_back,CloseSet_fore) 
            V_meet = CurP_back;
            flag_find=1; %找到目标点；搜索成功
            break;
        end
        %将地图中与CurP相邻的无碰撞的邻接点放入T集中[back motions,在当前图里面反向和正向是一样的，所以用的同一个函数]
        T_back=GetNearSpaceNode(MAX_X,MAX_Y,MAP,CurP_back);
        %将CurP的邻接点加入OpenSet开集(Heap)中
        %Dijkstra set the cost as the priority 
        [Dist_back,OpenSet_back,Visited_back]=UpdateOpenSet(T_back,CurP_back,Dist_back,xStart,yStart,OpenSet_back,heap,Visited_back); 
    end
    count = count + 1;
end
%绘制路径
if flag_find
    %最终路径结果
    result_path=plotPath(V_meet,CloseSet_fore,CloseSet_back,filename,false);    
else
    fprintf('WARN: 终点是障碍物区域!!!没有找到路径!!! 失败!!!\n');
end