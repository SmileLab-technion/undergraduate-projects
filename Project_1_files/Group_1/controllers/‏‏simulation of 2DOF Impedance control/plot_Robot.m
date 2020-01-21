function plot_Robot(X1 ,l1, l2, theta1, theta2, X_limit, Y_limit, Wall, video)

global Wall_x X0 Xf

disp('Begin Animation...')

%create figure elements
hFig = figure();
hAxes = axes(hFig);
hold on
xlim(hAxes,[-X_limit X_limit]);
ylim(hAxes,[-Y_limit Y_limit]);
grid on
axis equal
hMark = plot(nan,nan,'ro','MarkerSize',7);
hArm1 = line([nan,nan],[nan,nan],'LineWidth',3);
set(hArm1, 'color', 'k')
hArm2 = line([nan,nan],[nan,nan],'LineWidth',3);

c1 = cos(theta1);
s1 = sin(theta1);
c12 = cos(theta1+theta2);
s12 = sin(theta1+theta2);

l1_line_end = [l1.*c1; l1.*s1];
l2_line_end = [l2.*c12 ; l2.*s12]+l1_line_end;

Grip = zeros(2,length(X1(1,:)));  % initiate grip position log vector
hold on
grid on

% Plot Start and End Positions
plot(X0(1),X0(2), 'ob', Xf(1),Xf(2), 'xb','MarkerSize', 8, 'Linewidth', 2)
hold on

% Plot Wall
if (abs(Wall) > 0.05 && Wall==1)
     plot([Wall_x Wall_x], [-Y_limit Y_limit], '--r')
    hold on
end

% Start video 
if video == 1
    v = VideoWriter('video1.mp4');
    open(v)
end

for k=1:length(X1(2,:))
    
    Grip(1,k) = l2_line_end(1,k); % log grip position
    Grip(2,k) = l2_line_end(2,k);
    
    set(hArm1,'XData',[0, l1_line_end(1,k)],'YData',[0 , l1_line_end(2,k)]);
    set(hArm2,'XData',[l1_line_end(1,k), l2_line_end(1,k)],'YData',[l1_line_end(2,k) , l2_line_end(2,k)]);
    set(hMark,'XData',Grip(1,k),'YData',Grip(2,k));
    drawnow
    xlim(hAxes,[-X_limit X_limit]);
    
    if video == 1
        frame = getframe(gcf);
        writeVideo(v,frame);
    end
    
    plot(Grip(1,:), Grip(2, :), '*g')
   
end

if video == 1
    close(v)
end

disp('Finish Animation')

end

