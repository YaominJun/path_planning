function [vertex,XY]=plotPath(xTarget,yTarget,S,filename,flag_pause)

XS=[];XS=[XS,S.x];YS=[];YS=[YS,S.y];XY=[XS;YS];
XSF=[];XSF=[XSF,S.father_x];YSF=[];YSF=[YSF,S.father_y];XYF=[XSF;YSF];
index=find(XS==xTarget&YS==yTarget);
vertex=[];vertex=[vertex,index];
while index~=1
    xf=XYF(1,index);yf=XYF(2,index);
    index=find(XS==xf&YS==yf);
    %对于dijkstra等算法，和BFS、DFS不同的是，会有dist的更新
    %也可以新建一个PARENT矩阵来存，但matlab做这个没有C++等面对对象的语言方便。
    vertex=[vertex,index];
end

% plot(YS,XS,'*');
title('DFS, depth first search');
xlabel('y');
ylabel('x');
if flag_pause
    for i = 1:length(XS)
        plot(YS(i),XS(i),'b*');
        draw_animation(filename,i, 0);
    end
    plot(XY(2,vertex),XY(1,vertex),'linewidth', 1.5, 'color','r');
    draw_animation(filename,length(XS),1.5);
else
    for i = 1:length(XS)
        plot(YS(i),XS(i),'b*');
    end
    plot(XY(2,vertex),XY(1,vertex),'linewidth', 1.5, 'color','r');
end
