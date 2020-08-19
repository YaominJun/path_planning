function [x_Ob,y_Ob]=obstacle()
x_Ob=[];y_Ob=[];
%车道线作为边界障碍物
% x_Lane=[0 50 50 0];y_Lane=[7 7 6 6];y_Lane2=[-7 -7 -6 -6];
% x_Ob=[x_Ob,x_Lane];y_Ob=[y_Ob,y_Lane];
% x_Ob=[x_Ob,x_Lane];y_Ob=[y_Ob,y_Lane2];
%道路中小障碍物
%障碍物1
x_Ob1=[25 28 28 25];y_Ob1=[0 0 -1 -1];
x_Ob=[x_Ob,x_Ob1];y_Ob=[y_Ob,y_Ob1];
%障碍物2
% x_Ob2=[40 42 42 40];y_Ob2=[5 5 3 3];
% x_Ob=[x_Ob,x_Ob2];y_Ob=[y_Ob,y_Ob2];
x_Ob2=[40 42 42 40];y_Ob2=[10 10 8 8];
x_Ob=[x_Ob,x_Ob2];y_Ob=[y_Ob,y_Ob2];
x_Ob=reshape(x_Ob,4,length(x_Ob)/4);y_Ob=reshape(y_Ob,4,length(y_Ob)/4);
fill(x_Ob,y_Ob,'k');