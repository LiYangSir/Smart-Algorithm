function DrawRoute(position, Route)
N = length(Route);
scatter(position(:, 1), position(:, 2));
hold on;
plot([position(Route(1), 1), position(Route(N), 1)], [position(Route(1), 2), position(Route(N), 2)])
for i = 1: N - 1
    plot([position(Route(i), 1), position(Route(i + 1), 1)], [position(Route(i), 2), position(Route(i + 1), 2)], 'g')
    hold on;
end
end

