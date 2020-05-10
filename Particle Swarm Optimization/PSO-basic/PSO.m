function [xm, fv] = PSO(fitness, pop_size, c1, c2, w, epochs, chromosome_size)
format long;
for i = 1: pop_size
    for j = 1: chromosome_size
        x(i, j) = randn;
        v(i, j) = randn;
    end
end
for i = 1: pop_size
    p(i) = fitness(x(i, :));
    local(i, :) = x(i, :);
end
best = x(1, :);
for i = 1: pop_size - 1
    if fitness(x(i, :)) < fitness(best)
        best = x(i, :);
    end
end
for epoch = 1: epochs
    for i = 1: pop_size
       v(i, :) = w * v(i, :) + c1 * rand * (local(i, :) - x(i, :)) + c2 * rand * (best - x(i, :));
       x(i, :) = x(i, :) + v(i, :);   
        if fitness(x(i, :)) < p(i)
            p(i) = fitness(x(i, :));
            local(i, :) = x(i, :);
        end
        if p(i) < fitness(best)
            best = local(i, :);
        end
    end
    Pbest(epoch) = fitness(best);
end
disp('**************************************************');
disp('目标函数取最小值时的自变量:');
xm = best'
disp('目标函数取最小值:');
fv = fitness(best)
disp('**************************************************');
end
