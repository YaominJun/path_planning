function [result_path]=plotPath(V_meet,CloseSet_fore,CloseSet_back,filename,flag_pause)

%从起点出发到Vmeet
XS_fore=[];XS_fore=[XS_fore,CloseSet_fore.x];YS_fore=[];YS_fore=[YS_fore,CloseSet_fore.y];XY_fore=[XS_fore;YS_fore];
XSF_fore=[];XSF_fore=[XSF_fore,CloseSet_fore.father_x];YSF_fore=[];YSF_fore=[YSF_fore,CloseSet_fore.father_y];XYF_fore=[XSF_fore;YSF_fore];
index_fore=find(XS_fore==V_meet.x&YS_fore==V_meet.y);
vertex_fore=[];vertex_fore=[vertex_fore,index_fore];
while index_fore~=1
    xf_fore=XYF_fore(1,index_fore);yf_fore=XYF_fore(2,index_fore);
    index_fore=find(XS_fore==xf_fore&YS_fore==yf_fore);
    vertex_fore=[vertex_fore,index_fore];
end

%从终点出发到Vmeet
XS_back=[];XS_back=[XS_back,CloseSet_back.x];YS_back=[];YS_back=[YS_back,CloseSet_back.y];XY_back=[XS_back;YS_back];
XSF_back=[];XSF_back=[XSF_back,CloseSet_back.father_x];YSF_back=[];YSF_back=[YSF_back,CloseSet_back.father_y];XYF_fore=[XSF_back;YSF_back];
index_back=find(XS_back==V_meet.x&YS_back==V_meet.y);
vertex_back=[];vertex_back=[vertex_back,index_back];
while index_back~=1
    xf_back=XYF_fore(1,index_back);yf_back=XYF_fore(2,index_back);
    index_back=find(XS_back==xf_back&YS_back==yf_back);
    vertex_back=[vertex_back,index_back];
end

%合并路径结果
result_path = zeros(2, length(vertex_fore)+length(vertex_back)-1); %不用重复记录Vmeet
for i = 1:length(vertex_fore)
    result_path(1,i) = XY_fore(1,vertex_fore(length(vertex_fore)-i+1));
    result_path(2,i) = XY_fore(2,vertex_fore(length(vertex_fore)-i+1));
end
for i = 1:length(vertex_back)-1
    result_path(1,length(vertex_fore)+i) = XY_back(1,vertex_back(i+1)); %不用重复记录Vmeet
    result_path(2,length(vertex_fore)+i) = XY_back(2,vertex_back(i+1));
end

%绘制结果图
% plot(YS,XS,'*');
title('Bidirectional A*')
xlabel('y');
ylabel('x');
if flag_pause    
    for i = 1:min(length(XS_fore),length(XS_back))
        plot(YS_fore(i),XS_fore(i),'b*');
        plot(YS_back(i),XS_back(i),'y*');
        draw_animation(filename,i, 0);
    end
    plot(YS_fore(end),XS_fore(end),'b*'); %forward可能比backward多一个点
    draw_animation(filename,length(XS_fore),0);
    plot(result_path(2,:), result_path(1,:),'linewidth', 1.5, 'color','r');
    draw_animation(filename,length(XS_fore),1.5);
else
    for i = 1:min(length(XS_fore),length(XS_back))
        plot(YS_fore(i),XS_fore(i),'b*');
        plot(YS_back(i),XS_back(i),'y*');
    end
    plot(YS_fore(end),XS_fore(end),'b*'); %forward可能比backward多一个点
    plot(result_path(2,:), result_path(1,:),'linewidth', 1.5, 'color','r');
end
