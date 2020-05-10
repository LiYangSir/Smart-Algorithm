function similar_population = similarPopulation(pop)
    [m, n] = size(pop);
    h = 0;
    for i = 1:n
        s = sum(pop(:, i));
        if s == 0 || s == m
            h = h;
        else
            h = h - s / m * log2(s / m) - (m - s) / m * log2((m - s) / m);
        end
    end
    similar_population = 1 / (1 + h);
end