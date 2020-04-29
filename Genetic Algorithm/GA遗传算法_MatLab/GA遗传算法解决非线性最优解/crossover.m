%交叉变换
%输入变量：pop：二进制的父代种群数，pc：交叉的概率
%输出变量：newpop：交叉后的种群数
function [newpop] = crossover(pop,pc)
[px,py] = size(pop);
newpop = ones(size(pop));
for i = 1:2:px-1
    if(rand<pc)
        cpoint = round(rand*py);  % 交换位置
        newpop(i,:) = [pop(i,1:cpoint),pop(i+1,cpoint+1:py)];
        newpop(i+1,:) = [pop(i+1,1:cpoint),pop(i,cpoint+1:py)];
    else
        newpop(i,:) = pop(i,:);
        newpop(i+1,:) = pop(i+1,:);
    end
end