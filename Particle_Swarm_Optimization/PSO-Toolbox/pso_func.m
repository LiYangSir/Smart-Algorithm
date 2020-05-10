function z = pso_func(in)
n = size(in);
x = in(:, 1);
y = in(:, 2);
nx = n(1);
for i = 1: nx
   temp = 0.4 * (x(i) - 2)^2 + 0.3 * (y(i) - 4) ^2 - 0.7;
   z(i, :) = temp;
end
end