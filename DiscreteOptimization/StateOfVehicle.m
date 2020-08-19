function [theta,x_v,y_v,V]=StateOfVehicle()
%车辆状态信息获取
theta=-0.2;%表示车头初始航向角，一般与基准路径前进方向成锐角，否则将大转角，不合理。
x_v=0;y_v=-5;V=2;