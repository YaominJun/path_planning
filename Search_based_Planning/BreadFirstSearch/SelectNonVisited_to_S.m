function [S,count,Visited,flag_find,Queue]=SelectNonVisited_to_S(S,T,CurP,n0,Visited, flag_find, xTarget,yTarget,Queue,queue)
n=length(T);
count = 0;
for k=1:n
    if Visited(T(k).x, T(k).y) == 1
        continue;
    end
    count = count+1;
    S(count+n0).x=T(k).x;
    S(count+n0).y=T(k).y;
    S(count+n0).father_x=CurP.x;
    S(count+n0).father_y=CurP.y;
    Visited(T(k).x, T(k).y) = 1;
    Queue = queue.enQueue(Queue, S(count+n0));
    if T(k).x==xTarget&&T(k).y==yTarget
        flag_find=1;
        break;
    end
end