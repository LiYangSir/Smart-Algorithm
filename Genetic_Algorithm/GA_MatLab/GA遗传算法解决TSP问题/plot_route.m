% a: 所有城市的位置坐标
% R: 随机选择的一个种群

function plot_route(a, R)
    scatter(a(:, 1), a(:, 2), 'rx')
    hold on;
    plot([a(R(1), 1), a(R(length(R)), 1)], [a(R(1), 2), a(R(length(R)), 2)]) % 绘制起始点和终止点连线
    hold on;
    for i = 2:length(R)
        x0 = a(R(i - 1), 1);
        y0 = a(R(i - 1), 2);
        x1 = a(R(i), 1);
        y1 = a(R(i), 2);
        xx = [x0, x1];
        yy = [y0, y1];
        plot(xx, yy);
        hold on;
    end
end