%计算函数目标值
%输入变量：二进制数值
%输出变量：目标函数值
function [objvalue] = cal_objvalue(pop)
x = binary2decimal(pop);
%转化二进制数为x变量的变化域范围的数值
objvalue=10*sin(5*x)+7*abs(x-5)+10;