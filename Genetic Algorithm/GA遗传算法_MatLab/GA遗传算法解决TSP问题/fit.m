function fitness = fit(len, m, maxlen, minlen)
    fitness = len;
    for i = 1:length(len)
        fitness(i, 1) = (1 - (len(i)-minlen)/(maxlen-minlen+0.0001)).^m;
    end
end