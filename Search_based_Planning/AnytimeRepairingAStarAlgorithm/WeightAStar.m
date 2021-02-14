function [OpenSet, CloseSet] = WeightAStar(xStart,yStart,xTarget,yTarget,MAP,MAX_X,MAX_Y,e)
heap = heapFuns;
%载入地图
Dist = inf*ones(size(MAP)); Visited = zeros(size(MAP));
Dist(xStart,yStart)=0; Visited(xStart,yStart)=1;
V.x = xStart; V.y=yStart; V.father_x=xStart;V.father_y=yStart;
if MAP(xStart, yStart) == 0
    fprintf('WARN: 起点是障碍物区域!!!没有找到路径!!! 失败!!!\n');
    return;
end
V.Q=CalculateGCost(V.x,V.y,V,Dist)+e*CalculateHCost(V.x, V.y, xTarget,yTarget); 
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
    [Dist,OpenSet,Visited]=UpdateOpenSet(T,CurP,Dist,xTarget,yTarget,OpenSet,heap,Visited,e);
    count = count + 1;
end