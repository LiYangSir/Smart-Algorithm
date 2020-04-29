% 运行主程序
clear;
clc;
%% 输入参数
county_size = 10;
countys_size = 40;
epoch = 200;
m = 2;      % 适应值归一化淘汰加速指数，大的更大， 小的更小
cross_rate = 0.4;
mutation_rate = 0.2;
%% 生成基本矩阵
% 生成城市坐标
position = randn(county_size, 2);
% 生成城市之间的距离矩阵
distance = zeros(county_size, county_size);
for i = 1:county_size
    for j = i+1:county_size
        dis = (position(i, 1) - position(j, 1))^2 + (position(i, 2) - position(j, 2))^2;
        distance(i, j) = dis^0.5;
        distance(j, i) = distance(i, j);
    end
end
% 生成初始种群
population = zeros(countys_size, county_size);
for i = 1: countys_size
    population(i, :) = randperm(county_size);
end
% %% 随机选择一个种群
% pop = population(1, :);
% figure(1);
% scatter(position(:, 1), position(:, 2), 'k.');
% xlabel('x');
% ylabel('y');
% title('随机城市分布情况');
% axis([-3, 3, -3, 3]);
% figure(2);
% plot_route(position, pop);
% xlabel('x');
% ylabel('y');
% title('随机城市路径分布情况');
% axis([-3, 3, -3, 3]);
%% 初始化种群及其适应度函数
fitness = zeros(countys_size, 1);
len = zeros(countys_size, 1);
for i = 1: countys_size
    len(i, 1) = myLength(distance, population(i, :));
end
maxlen = max(len);
minlen = min(len);
fitness = fit(len, m, maxlen, minlen);
rr = find(len == minlen);  % 调试查询结果
pop = population(rr(1, 1), :);
for i = 1: county_size
    fprintf('%d  ', pop(i));
end
fprintf('\n');
fitness = fitness/sum(fitness);
distance_min = zeros(epoch + 1, 1);
population_sel = zeros(countys_size + 1, county_size);
%% 开始迭代
while epoch >= 0
    fprintf('迭代次数： %d\n', epoch);
    nn = 0;
    p_fitness = cumsum(fitness);
    for i = 1:size(population, 1)
        len_1(i, 1) = myLength(distance, population(i, :));
        jc = rand;
        for j = 1: size(population, 1)
            if p_fitness(j, 1) > jc
                nn  = nn + 1;
                population_sel(nn, :) = population(j, :);
                break;
            end
        end
    end
    %% 每次选择保存最优种群
    population_sel = population_sel(1:nn, :);
    [len_m, len_index] = min(len_1);
    [len_max, len_index_max] = max(len_1);
    population_sel(len_index_max, :) = population_sel(len_index, :);
    %% 交叉操作
    nnper = randperm(nn);
    A = population_sel(nnper(1), :);
    B = population_sel(nnper(2), :);
    for i = 1 : nn * cross_rate
        [A, B] = cross(A, B);
        population_sel(nnper(1), :) = A;
        population_sel(nnper(2), :) = B;
    end
    %% 变异操作
    for i = 1: nn
        pick = rand;
        while pick == 0
            pick = rand;
        end
        if pick <= mutation_rate
            population_sel(i, :) = mutation(population_sel(i, :));
        end
    end
    %% 逆转函数
    for i = 1: nn
        population_sel(i,:) = reverse(population_sel(i,:), distance);
    end
    %% 适应度函数更新
    NN = size(population_sel, 1);
    len = zeros(NN, 1);
    for i = 1: NN
        len(i, 1) = myLength(distance, population_sel(i, :));
    end
    maxlen = max(len);
    minlen = min(len);
    distance_min(epoch+1, 1) = minlen;
    fitness = fit(len, m, maxlen, minlen);
    rr = find(len == minlen);  % 调试查询结果
    fprintf('minlen： %d\n', minlen);
    pop = population(rr(1, 1), :);
    for i = 1: county_size
        fprintf('%d  ', pop(i));
    end
    fprintf('\n');
    population = population_sel;
    epoch = epoch - 1;
end
figure(3);
plot_route(position, pop)
xlabel('x');
ylabel('y');
title('最优城市路径分布情况');
axis([-3, 3, -3, 3]);   