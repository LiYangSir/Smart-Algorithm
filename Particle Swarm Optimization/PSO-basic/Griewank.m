function y = Griewank(x)
[row, col] = size(x);
if row > 1
   error('ÊäÈë²ÎÊı´íÎó'); 
end
y1 = 1 / 4000 * sum(x.^2);
y2 = 1;
for h = 1: col
    y2 = y2 * cos(x(h) / sqrt(h));
end
y = y1 - y2 + 1;
y = -y;
end