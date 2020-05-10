function pop = cross(pop, cross_rate, pop_size, chromosome_size)
    j = 1;
    for i = 1: pop_size
        p = rand;
        if p <= cross_rate
            parent(j, :) = pop(i, :);
            a(1, j) = i;
            j = j + 1;
        end
    end
    j = j - 1;
    if rem(j, 2) ~= 0
        j = j - 1;
    end
    for i = 1: 2: j
        p = round(randn(1, chromosome_size));
        for k = 1: chromosome_size
            if p(1, k) == 1
                pop(a(1, i), k) = parent(i + 1, k);
                pop(a(1, i + 1), k) = parent(i, k);
            end
        end
    end    
end