function cost=CalculateGCost(Neighborx,Neighbory,CurP, Dist)
%计算邻接点的代价G Cost
cost = Dist(CurP.x, CurP.y)+sqrt((Neighborx-CurP.x)^2+(Neighbory-CurP.y)^2);
