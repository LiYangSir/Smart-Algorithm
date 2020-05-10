function [T, AAS] =  ReproduceFun(clone_size, cfactor, pop_size, Affinity, pop, T)
if clone_size == 1
    T = ones(pop_size, 1) * pop(Affinity(end), :);
else
    for i = 1: clone_size
        CS(i) = round(cfactor * pop_size);  % ¿ËÂ¡´ÎÊý
        AAS(i) = sum(CS);
        ONES = ones(CS(i), 1);
        subscript = Affinity(end - i + 1);
        T = [T; ONES * pop(subscript, :)];
    end
end
end