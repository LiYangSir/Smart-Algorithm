clear all
clc
Ants = 300;
Times = 80;
Rou = 0.9;
P0 = 0.2;
x_lower = -1;
y_lower = -1;
x_upper = 1;
y_upper = 1;
%% 随机生成蚁群位置
ant = zeros(Ants, 2);
for i = 1: Ants
    ant(i, 1) = x_lower + (x_upper - x_lower) * rand;
    ant(i, 2) = y_lower + (y_upper - y_lower) * rand;
    Tau(i) = F(ant(i, 1), ant(i, 2));  % 信息素
end

step = 0.05;
f = '-(x.^4 + 3 * y.^4 - 0.2 * cos(3 * pi * x) - 0.4 * cos(4 * pi * y) + 0.6)';
%% 画图
[x, y] = meshgrid(x_lower:step:x_upper, y_lower:step:y_upper);
z = eval(f);
figure(1);
subplot(121);
mesh(x, y ,z)
hold on;
plot3(ant(:, 1), ant(:, 2), Tau, 'k*');
hold on;
%% 开始迭代
for T = 1:Times
    lamda = 1 / T;
    [Tau_Best(T), BestIndex] = max(Tau);
    for i = 1: Ants
        P(T, i) = (Tau(BestIndex) - Tau(i)) / Tau(BestIndex);
    end
    for i = 1: Ants
        if P(T, i) < P0  % 局部搜索
            temp1 = ant(i, 1) + (2 * rand - 1) * lamda;
            temp2 = ant(i, 2) + (2 * rand - 1) * lamda;
        else  % 全局搜索
            temp1 = ant(i, 1) + (2 * rand - 1);
            temp2 = ant(i, 2) + (2 * rand - 1);
        end
        if temp1 < x_lower
            temp1 = x_lower;
        end
        if temp2 < y_lower
            temp2 = y_lower;
        end
        if temp1 > x_upper
            temp1 = x_upper;
        end
        if temp2 > y_upper
            temp2 = y_upper;
        end
        if F(temp1, temp2) > F(ant(i, 1), ant(i, 2))
            ant(i, 1) = temp1;
            ant(i, 2) = temp2;
        end
    end
    for i = 1: Ants
        Tau(i) = (1 - Rou) * Tau(i) + F(ant(i, 1), ant(i, 2));
    end
end
subplot(122);
mesh(x, y ,z);
hold on;
x = ant(:, 1);
y = ant(:, 2);
plot3(x, y ,eval(f), 'k*');
hold on;

[max_value, max_index] = max(Tau);
max_X = ant(max_index, 1);
max_Y = ant(max_index, 2);
max_value = F(max_X, max_Y);
fprintf('max_X = %d, max_Y = %d, max_value = %d', max_X, max_Y, max_value)