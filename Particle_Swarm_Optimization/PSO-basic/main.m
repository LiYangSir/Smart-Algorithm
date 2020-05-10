clear
clc
% [xm1, fv1] = PSO(@fitness, 50, 1.5, 2.5, 0.5, 100, 30);
% [xm2, fv2] = PSO(@fitness, 50, 1.5, 2.5, 0.5, 1000, 30);
% [xm3, fv3] = PSO(@fitness, 50, 1.5, 2.5, 0.5, 10000, 30);

% [xm1, fv1] = PSO(@fitness, 50, 1.5, 2.5, 0.5, 100, 30);
% [xm2, fv2] = PSO(@fitness, 100, 1.5, 2.5, 0.5, 100, 30);
% [xm3, fv3] = PSO(@fitness, 200, 1.5, 2.5, 0.5, 100, 30);

[xm1, fv1] = PSO(@fitness, 50, 1.5, 1.5, 0.5, 100, 30);
[xm2, fv2] = PSO(@fitness, 100, 1.5, 1.5, 0.5, 100, 30);
[xm3, fv3] = PSO(@fitness, 500, 1.5, 1.5, 0.5, 100, 30);

