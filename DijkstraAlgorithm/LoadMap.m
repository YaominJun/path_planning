function [xStart,yStart,xTarget,yTarget,MAP,MAX_X,MAX_Y]=LoadMap()

%第一种栅格图
a = [0 1 0 0 1 1;    0 1 1 0 1 1;    0 0 0 1 1 1;    0 1 1 1 0 1];%栅格地图
xStart=1;yStart=2;
xTarget=4;yTarget=6;
%第二种栅格图
% a = ones(66,20);a(4:59,3)=0;a(4:59,5)=0;a(4:59,7)=0;a(4:59,9)=0;a(4:59,11)=0;a(62,1:5)=0;a(62,8:12)=0;a(1:62,13:15)=0;a(1:66,19:20)=0;a(1:40,15:19)=0;a(1,1:19)=0;a(1:66,1)=0;a(66,1:19)=0;a(41:46,15:19)=1;a(63:65,1)=1;
% xStart=46;yStart=17;
% xTarget=60;yTarget=3;

b = a;
b(end+1,end+1) = 0;
colormap([0 0 0;1 1 1])%给栅格附上颜色，000为黑色，111为白色
pcolor(0.5:size(a,2)+0.5,0.5:size(a,1)+0.5,b); % 赋予栅格颜色
set(gca,'XTick',1:size(a,2),'YTick',1:size(a,1));  % 设置坐标
axis image xy;  % 沿每个坐标轴使用相同的数据单位，保持一致
% xStart=46;yStart=17;
% xTarget=60;yTarget=3;
MAP=a;MAX_X=size(a,1);MAX_Y=size(a,2);
hold on