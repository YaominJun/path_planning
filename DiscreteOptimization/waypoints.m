function pa=waypoints()
%给定全局路点，进行拟合。
x_waypoint=0:10:50;y_waypoint=[-4,-3.5,-2,5,6,8];
pa=polyfit(x_waypoint,y_waypoint,3);
