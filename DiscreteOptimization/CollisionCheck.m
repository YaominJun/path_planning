function [collision_lateral,collision_longitu]=CollisionCheck(x_Candidate,x_Ob,y_Candidate,y_Ob,V,x_v)
%碰撞风险分析
[row_C,column_C]=size(x_Candidate);
[~,column_Ob]=size(x_Ob);
collision=zeros(1,column_C);collision_loc=zeros(1,column_C);
for i=1:column_C
    for j=1:column_Ob 
           %第i条候选路径上距离障碍物左端最近的点
           x_C_Ob1=find((x_Candidate(:,i)-x_Ob(1,j))>=0,1);
           if x_C_Ob1>1 && (x_Candidate(x_C_Ob1,i)-x_Ob(1,j))>0 && x_C_Ob1-1>0
               x_C_Ob1=x_C_Ob1-1;
           end           
           y_C_Ob1=y_Candidate(x_C_Ob1,i);x_C_Ob1=x_Candidate(x_C_Ob1,i);
           %第i条候选路径上距离障碍物右端最近的点
           x_C_Ob2=find(x_Candidate(:,i)-x_Ob(2,j)<=0,1,'last');
           if x_C_Ob2<row_C && (x_Candidate(x_C_Ob2,i)-x_Ob(2,j))<0 && x_C_Ob2+1<row_C
               x_C_Ob2=x_C_Ob2+1;
           end           
           y_C_Ob2=y_Candidate(x_C_Ob2,i);x_C_Ob2=x_Candidate(x_C_Ob2,i);
           %求距离障碍物左端最近的点与障碍物之间的斜率范围
           t1=min(min((y_Ob(:,j)-y_C_Ob1)./(x_Ob(:,j)-x_C_Ob1)));
           t2=max(max((y_Ob(:,j)-y_C_Ob1)./(x_Ob(:,j)-x_C_Ob1)));
           t=(y_C_Ob2-y_C_Ob1)./(x_C_Ob2-x_C_Ob1);
           if t>=t1 && t<=t2
               collision(i)=1;collision_loc(i)=x_C_Ob1;
           end        
    end    
end
collision_lateral=zeros(1,length(collision));collision_longitu=zeros(1,length(collision));
detat=20;
l_s=V*detat+5;
for i=1:length(collision)
    for j=1:length(collision)
        if abs(j-i)<4
            collision_lateral(i)=collision_lateral(i)+collision(j)*(1-(abs(j-i)/4));%横向风险         
        end
    end
    if collision(i) && collision_loc(i)-x_v<l_s
        collision_longitu(i)=1-((collision_loc(i)-x_v)/l_s);%纵向风险
    end
end
