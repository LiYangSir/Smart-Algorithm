%二进制转化成十进制函数
%输入变量：
%二进制种群
%输出变量
%十进制数值
function pop2 = binary2decimal(pop)
[px,py]=size(pop);
for i = 1:py
    pop1(:,i) = 2.^(py-i).*pop(:,i);
end
%sum(.,2)对行求和，得到列向量
temp = sum(pop1,2);
pop2 = temp*10/1023;