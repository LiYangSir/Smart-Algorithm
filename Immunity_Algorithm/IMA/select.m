function pop = select(pop, fitness)
    [px, ~] = size(pop);
    pfit = zeros(1, px);
    for i = 1: px
        pfit(i) = fitness(i)./ sum(fitness);
    end
    pfit = cumsum(pfit);
    if pfit(end) < 1
        pfit(end) = 1;
    end

    for i = 1: 10
        for j = 1: px
            if rand <= pfit(j)
                pop(i, :) = pop(j, :);
                break;
            end
        end
    end
end