function f = fit(similar_chromosome, fitness)
    t = 0.8;
    [m, m] = size(similar_chromosome);
    k = -0.8;
    for i = 1:m
        n = 0;
        for j = 1: m
            if similar_chromosome(i, j) > t
                n = n + 1;
            end
        end
        C(1, i) = n / m;
    end
    f = fitness .* exp(k * C);
end