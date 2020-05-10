function Decimal = DecodeFun(pop, xmin, xmax)
pop = fliplr(pop);
pop_size = size(pop);
M = ones(pop_size(1), 1) * (0: 1: 21);
Decimal = sum((pop .* 2.^M)');
Decimal = xmin + (xmax - xmin) * Decimal ./ (2^22 - 1);
end