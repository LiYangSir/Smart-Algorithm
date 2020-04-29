% distance:距离矩阵，类似于图的保存方式，保存每一个城市之间的距离，大小：N*N
% chromosome: 对于单个染色体，里面存储了所有城市的随机排序
function len = myLength(distance, chromosome)
    [~, N] = size(distance);
    len = distance(chromosome(1, N), chromosome(1, 1));
    for i = 1:(N-1)
        len = len + distance(chromosome(1, i), chromosome(1, i + 1));
    end
end