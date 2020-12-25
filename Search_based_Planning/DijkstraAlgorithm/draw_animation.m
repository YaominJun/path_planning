function draw_animation(filename, i, t)

% drawnow; % Ë¢ÐÂÆÁÄ» 
% pause(0.01);
f = getframe(gcf);
imind = frame2im(f);
[imind,cm] = rgb2ind(imind,256);
if i == 1
    imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',t);
else
    imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',t);
end
