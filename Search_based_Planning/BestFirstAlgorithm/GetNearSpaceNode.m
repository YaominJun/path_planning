function T=GetNearSpaceNode(MAX_X,MAX_Y,MAP,CurP)
T = [];
Motions = [-1, 0; -1, 1; 0, 1; 1, 1; 1, 0; 1, -1; 0, -1; -1, -1];
[r, ~] = size(Motions);
for i = 1 : r
    V.x = CurP.x + Motions(i,1); V.y = CurP.y + Motions(i,2);
    if V.x>=1&&V.x<=(MAX_X)&&V.y>=1&&V.y<=(MAX_Y)&&MAP(V.x,V.y)==1
        T=[T,V];
    end
end