%关于编译
%函数说明
%输入变量：pop：二进制种群，pm：变异概率
%输出变量：newpop变异以后的种群
function [newpop] = mutation(pop,pm)
[px,py] = size(pop);
newpop = ones(size(pop));
for i = 1:px
    if(rand<pm)
        mpoint = round(rand*py); % 变异位置
        if mpoint <= 0
            mpoint = 1;
        end
        newpop(i,:) = pop(i,:);
        if newpop(i,mpoint) == 0  % 取反操作
            newpop(i,mpoint) = 1;
        else newpop(i,mpoint) == 1
            newpop(i,mpoint) = 0;
        end
    else newpop(i,:) = pop(i,:);
    end
end