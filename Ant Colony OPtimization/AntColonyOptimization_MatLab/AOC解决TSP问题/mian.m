clear;
clc;
x=[51 27 56 21 4 6 58 71 54 40 94 18 89 33 12 25 24 58 71 94 17 38 13 82 12 58 45 11 47 4]';
y=[14 81 67 92 64 19 98 18 62 69 30 54 10 46 34 18 42 69 61 78 16 40 10 7 32 17 21 26 35 90]';
position = 50 * randn(40, 2);
% position = [x, y];
epochs = 50;
ants = 40;
alpha = 1.4;
beta = 2.2;
rho = 0.15;Q = 10^6;
cities = size(position, 1);
% 城市之间的距离矩阵
Distance = ones(cities, cities);
for i = 1: cities
    for j = 1: cities
        if i ~= j
            Distance(i, j) = ((position(i, 1) - position(j, 1))^2 + (position(i, 2) - position(j, 2))^2)^0.5;
        else
            Distance(i, j) = eps;
        end
        Distance(j, i) = Distance(i, j);
    end
end
Eta = 1./Distance;
Tau = ones(cities, cities);
% 每只蚂蚁的路线图
Route = zeros(ants, cities);
epoch = 1;
% 记录每回合最优城市
R_best = zeros(epochs, cities);
L_best = inf .* ones(epochs, 1);
L_ave = zeros(epochs, 1);
% 开始迭代
while epoch <= epochs
    % 随机位置
    RandPos = [];
    for i = 1: ceil(ants / cities)
        RandPos = [RandPos, randperm(cities)];
    end
    Route(:, 1) = (RandPos(1, 1:ants))';
    for j = 2:cities
        for i = 1: ants
            Visited = Route(i, 1:j-1);
            NoVisited = zeros(1, (cities - j + 1));
            P = NoVisited;
            num = 1;
            for k = 1: cities
                if length(find(Visited == k)) == 0
                    NoVisited(num) = k;
                    num = num + 1;
                end
            end
            for k = 1: length(NoVisited)
                P(k) = (Tau(Visited(end), NoVisited(k))^alpha) * (Eta(Visited(end), NoVisited(k))^beta);
            end
            P = P / sum(P);
            Pcum = cumsum(P);
            select = find(Pcum >= rand);
            to_visit = NoVisited(select(1));
            Route(i, j) = to_visit;
        end
    end
    if epoch >= 2
        Route(1, :) = R_best(epoch - 1, :);
    end
    Distance_epoch = zeros(ants, 1);
    for i = 1: ants
        R = Route(i, :);
        for j = 1: cities - 1
            Distance_epoch(i) = Distance_epoch(i) + Distance(R(j), R(j + 1));
        end
        Distance_epoch(i) = Distance_epoch(i) + Distance(R(1), R(cities));
    end
    L_best(epoch) = min(Distance_epoch);
    pos = find(Distance_epoch == L_best(epoch));
    R_best(epoch, :) = Route(pos(1), :);
    L_ave(epoch) = mean(Distance_epoch);
    epoch = epoch + 1;
    
    Delta_Tau = zeros(cities, cities);
    for i = 1: ants
        for j = 1: (cities - 1)
            Delta_Tau(Route(i, j), Route(i, j + 1)) = Delta_Tau(Route(i, j), Route(i, j + 1)) + Q / Distance_epoch(i);
        end
        Delta_Tau(Route(i, 1), Route(i, cities)) = Delta_Tau(Route(i, 1), Route(i, cities)) + Q / Distance_epoch(i);
    end
    Tau = (1 - rho) .* Tau + Delta_Tau;
    Route = zeros(ants, cities);
end
%% 结果展示
Pos = find(L_best == min(L_best));
Short_Route = R_best(Pos(1), :);
Short_Length = L_best(Pos(1), :);
figure
subplot(121);
DrawRoute(position, Short_Route);
subplot(122);
plot(L_best);
hold on
plot(L_ave, 'r');
title('平均距离和最短距离');
