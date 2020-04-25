clear;
clc;
%种群大小
popsize=100;
%二进制编码长度
chromlength=10;
%交叉概率
pc = 0.6;
%变异概率
pm = 0.001;
%初始种群
pop = initpop(popsize,chromlength);  % 100 * 10 的种群大小

for i = 1:100
    %计算适应度值（函数值）
    objvalue = cal_objvalue(pop);
    fitvalue = objvalue;
    %选择操作 按照适应度选择新的适应群体
    newpop = selection(pop,fitvalue);
    %交叉操作
    newpop = crossover(newpop,pc);
    %变异操作
    newpop = mutation(newpop,pm);
    %更新种群
    pop = newpop;
    %寻找最优解
    [bestindividual,bestfit] = best(pop,fitvalue);
    x2 = binary2decimal(bestindividual);
    x1 = binary2decimal(newpop);
    y1 = cal_objvalue(newpop);
    if mod(i,25) == 0
        %figure;
        subplot(2, 2, i/25);
        fplot(@(x)10*sin(5*x)+7*abs(x-5)+10,[0 10]);
        hold on;
        plot(x1,y1,'*');
        title(['迭代次数为n=' num2str(i)]);
        %plot(x1,y1,'*');
    end
end
fprintf('The best X is --->>%5.2f\n',x2);
fprintf('The best Y is --->>%5.2f\n',bestfit);