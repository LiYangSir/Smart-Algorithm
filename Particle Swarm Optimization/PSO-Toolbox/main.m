clear
clc
x_range = [-40, 40];
y_range = [-40, 40];
range = [x_range; y_range];
Max_V = 0.2 * (range(:, 2) - range(:, 1));
n = 2;
% pso_Trelea_vectorized('pso_func', n, Max_V, range)
figure('color', 'k');
subplot(121);
axis off;
axis([1, 10, 1, 10]);
text(0, 1, 'asdasd', 'Color', 'b', 'FontSize', 15);
text(0, 1.5, 'asdddddd', 'color', 'r');
text(0, 2, 'asdddddd', 'color', 'r');
text(0, 3, 'asdddddd', 'color', 'r');
subplot(122);
axis off;
axis([1, 10, 1, 10]);
text(0, 0, 'asdasd', 'color', 'b');
text(0, 5, 'asdddddd', 'color', 'r');