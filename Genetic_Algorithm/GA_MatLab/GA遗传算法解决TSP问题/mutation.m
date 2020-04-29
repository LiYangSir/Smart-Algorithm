function chromosome = mutation(chromosome)
    nnper = randperm(size(chromosome, 2));
    index1 = nnper(1);
    index2 = nnper(2);
    temp = chromosome(index1);
    chromosome(index1) = chromosome(index2);
    chromosome(index2) = temp;
end