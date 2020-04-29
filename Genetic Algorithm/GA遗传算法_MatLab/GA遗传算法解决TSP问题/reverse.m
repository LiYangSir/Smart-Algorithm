function chromosome = reverse(chromosome, distance)
    [row, col] = size(chromosome);
    ObjV = myLength(distance, chromosome);
    chromosome1 = chromosome;
    for i = 1: row
        r1 = randsrc(1, 1, [1:col]);
        r2 = randsrc(1, 1, [1:col]);
        mininverse = min([r1, r2]);
        maxinverse = max([r1, r2]);
        chromosome1(1, mininverse:maxinverse) = chromosome1(i, maxinverse:-1:mininverse);
    end
    ObjV1 = myLength(distance, chromosome1);
    if ObjV1 < ObjV
        chromosome = chromosome1;
    end
end