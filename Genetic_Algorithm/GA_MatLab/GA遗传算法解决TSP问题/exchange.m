function [x, y] = exchange(x, y)
    temp = x;
    x = y;
    y = temp;
end