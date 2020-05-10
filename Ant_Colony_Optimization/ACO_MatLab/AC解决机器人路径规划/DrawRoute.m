function DrawRoute(X, Y)
for i = 2: length(X)
    plot([X(i - 1), X(i)], [Y(i - 1), Y(i)], 'b-')
    hold on
    pause(0.1)
    frame = getframe(gcf);
    imind = frame2im(frame);
    [imind, cm] = rgb2ind(imind, 256);
    if i == 2
        imwrite(imind, cm, 'test.gif', 'gif', 'Loopcount', inf, 'DelayTime', 1e-4);
    else
        imwrite(imind, cm, 'test.gif', 'gif', 'WriteMode', 'append', 'DelayTime', 1e-4);
    end
    
end