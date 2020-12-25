function flag = inSet(CurP,OpenSet)
flag = false;
for i = 1:length(OpenSet)
    if CurP.x == OpenSet(i).x && CurP.y == OpenSet(i).y
        flag = true;
        break;
    end
end
