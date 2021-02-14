function cost=CalculateHCost(Neighborx,Neighbory,xTarget,yTarget)
%计算启发项Heuristic的代价
cost = sqrt((Neighborx-xTarget)^2+(Neighbory-yTarget)^2);