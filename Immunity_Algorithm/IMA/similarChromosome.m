function similar_chromosome = similarChromosome(pop)
    [m, n] = size(pop);
    similar_chromosome = zeros(m, m);
    for i = 1:m
        for j = 1:m
            if i == j
                similar_chromosome(i, j) = 1;
            else
                H(i, j) = 0;
                for k = 1:n
                    if pop(i, k) ~= pop(j, k)
                        H(i, j) = H(i, j) + 1;
                    end
                end
                H(i, j) = H(i, j) / n;
                similar_chromosome(i, j) = 1 / (1 + H(i, j));
            end
        end
    end
end