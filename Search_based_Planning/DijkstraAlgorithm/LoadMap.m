function [xStart,yStart,xTarget,yTarget,MAP,MAX_X,MAX_Y]=LoadMap()
%第一种栅格图
a = ones(40,50);
a(5,5:45)=0; a(35,5:45)=0; a(5:35,5)=0; a(5:35,45)=0; %边框
a(5:20,20)=0; a(20,10:20)=0; a(20:35,30)=0; a(5:20,40)=0; %障碍物
xStart=10;yStart=10;
xTarget=30;yTarget=40;
% %第二种栅格图
% a = ones(20,20);
% a(4:10,3)=0; a(4,4:8)=0; a(15,11:16)=0; a(1:14,16)=0; %栅格地图
% xStart=1;yStart=2;
% xTarget=6;yTarget=15;

b = a;
b(end+1,end+1) = 0;
colormap([0 0 0;1 1 1])%给栅格附上颜色，000为黑色，111为白色
pcolor(0.5:size(a,2)+0.5,0.5:size(a,1)+0.5,b); % 赋予栅格颜色
set(gca,'XTick',1:5:size(a,2),'YTick',1:5:size(a,1));  % 设置坐标
axis image xy;  % 沿每个坐标轴使用相同的数据单位，保持一致
MAP=a;MAX_X=size(a,1);MAX_Y=size(a,2);
hold on
scatter(yStart, xStart, 120, 'gs','filled','LineWidth',0.5, 'MarkerFaceColor', 'g');
scatter(yTarget, xTarget,120, 'rs','filled','LineWidth',0.5, 'MarkerFaceColor', 'r');