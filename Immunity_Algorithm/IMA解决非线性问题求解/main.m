clear
clc
tic
pop_size = 65;
chromosome_size = 22;
clone_size = 60;
xmin = 0;
xmax = 8;
epochs = 100;
pMutate = 0.1;
cfactor = 0.3;
pop = InitializeFun(pop_size, chromosome_size);
F = 'X + 10 * sin(X .* 5) + 9 * cos(X .* 4)';
E_best = [];
E_ave = [];
epoch = 0;
while epoch < epochs
    epoch = epoch + 1;
    X = DecodeFun(pop, xmin, xmax);
    Fit = eval(F);
    if epoch == 1
        figure(1);
        fplot(F, [xmin, xmax]);
        grid on;
        hold on;
        plot(X, Fit, 'k*');
        title('抗体的初始化位置分布图');
        xlabel('x');
        ylabel('y');
    end
    if epoch <= epochs
        figure(2);
        fplot(F, [xmin, xmax], 'b');
        grid on;
        hold on;
        plot(X, Fit, 'r*');
        hold off;
        title('抗体的最终位置分布图');
        xlabel('x');
        ylabel('y');
        pause(0.01);
    end
    Clone = [];
    [FS, Affinity] = sort(Fit, 'ascend');
    XT = X(Affinity(end - clone_size + 1: end));
    FT = FS(end - clone_size + 1: end);
    E_best = [E_best, FT(end)];
    [Clone, AAS] = ReproduceFun(clone_size, cfactor, pop_size, Affinity, pop, Clone);
    Clone = Hypermutation(Clone, chromosome_size, pMutate);
    AF = fliplr(Affinity(end - clone_size + 1: end));
    Clone(AAS, :) = pop(AF, :);
    X = DecodeFun(Clone, xmin, xmax);
    Fit = eval(F);
    AAS = [0 AAS];
    E_ave = [E_ave, mean(Fit)];
    for i = 1: clone_size
        [OUT(i), BBS(i)] = max(Fit(AAS(i) + 1 : AAS(i + 1)));
        BBS(i) = BBS(i) + AAS(i);
    end
    
    AF2 = fliplr(Affinity(end - clone_size + 1 : end));
    pop(AF2, :) = Clone(BBS, :);
end
fprintf('\n The optimal point is: ');
fprintf('\n x: %2.4f. f(x): %2.4f', XT(end), E_best(end));

figure(3)
grid on 
plot(E_best)
title('适应值变化趋势')
xlabel('迭代数')
ylabel('适应值')
hold on
plot(E_ave,'r')
hold off
grid on
toc