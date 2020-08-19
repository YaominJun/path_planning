function [T,MAP]=GetNearSpaceNode(S,MAX_X,MAX_Y,MAP,T,i)
%下方
if (S(i).x)>=1&&(S(i).x)<=(MAX_X)&&(S(i).y)-1>=1&&(S(i).y)-1<=(MAX_Y)&&MAP((S(i).x),(S(i).y)-1)==1
    T=[T,(S(i).x),(S(i).y)-1];end
%上方
if (S(i).x)>=1&&(S(i).x)<=(MAX_X)&&(S(i).y)+1>=1&&(S(i).y)+1<=(MAX_Y)&&MAP((S(i).x),(S(i).y)+1)==1
    T=[T,(S(i).x),(S(i).y)+1];end
%左方
if (S(i).x)-1>=1&&(S(i).x)-1<=(MAX_X)&&(S(i).y)>=1&&(S(i).y)<=(MAX_Y)&&MAP((S(i).x)-1,(S(i).y))==1
    T=[T,(S(i).x)-1,(S(i).y)];end
%右方
if (S(i).x)+1>=1&&(S(i).x)+1<=(MAX_X)&&(S(i).y)>=1&&(S(i).y)<=(MAX_Y)&&MAP((S(i).x)+1,(S(i).y))==1
    T=[T,(S(i).x)+1,(S(i).y)];end
%左下角
if (S(i).x)-1>=1&&(S(i).x)-1<=(MAX_X)&&(S(i).y)-1>=1&&(S(i).y)-1<=(MAX_Y)&&MAP((S(i).x)-1,(S(i).y)-1)==1
    T=[T,(S(i).x)-1,(S(i).y)-1];end
%左上角
if (S(i).x)-1>=1&&(S(i).x)-1<=(MAX_X)&&(S(i).y)+1>=1&&(S(i).y)+1<=(MAX_Y)&&MAP((S(i).x)-1,(S(i).y)+1)==1
    T=[T,(S(i).x)-1,(S(i).y)+1];end
%右上角
if (S(i).x)+1>=1&&(S(i).x)+1<=(MAX_X)&&(S(i).y)+1>=1&&(S(i).y)+1<=(MAX_Y)&&MAP((S(i).x)+1,(S(i).y)+1)==1
    T=[T,(S(i).x)+1,(S(i).y)+1];end
%右下角
if (S(i).x)+1>=1&&(S(i).x)+1<=(MAX_X)&&(S(i).y)-1>=1&&(S(i).y)-1<=(MAX_Y)&&MAP((S(i).x)+1,(S(i).y)-1)==1
    T=[T,(S(i).x)+1,(S(i).y)-1];end
