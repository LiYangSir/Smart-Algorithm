function DrawRouteGif(pos, population)
[m, n] = size(population);
for i = 1: m
    hold off
    scatter(pos(:, 1), pos(:, 2));
    hold on
    plot([pos(population(i, 1), 1), pos(population(i, n), 1)], [pos(population(i, 1), 2), pos(population(i, n), 2)], 'g');
    for ii = 2: n
        plot([pos(population(i, ii - 1), 1), pos(population(i, ii), 1)], [pos(population(i, ii - 1), 2), pos(population(i, ii), 2)], 'g');
    end
    pause(0.1)
    frame = getframe(gcf);
    imind = frame2im(frame);
    [imind, cm] = rgb2ind(imind, 256);
    if i == 1
        imwrite(imind, cm, 'test.gif', 'gif', 'Loopcount', inf, 'DelayTime', 1e-4);
    else
        imwrite(imind, cm, 'test.gif', 'gif', 'WriteMode', 'append', 'DelayTime', 1e-4);
    end
end

title('旅行商规划');