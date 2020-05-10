function pop = mutation(pop, mutation_rate, chromosome_size, pop_size)
    for i = 1: pop_size
        s = rand(1, chromosome_size);
        for j = 1: chromosome_size
            if s(1, j) < mutation_rate
                if pop(i, j) == 1
                    pop(i, j) = 0;
                else
                    pop(i, j) = 1;
                end
            end
        end
    end
end