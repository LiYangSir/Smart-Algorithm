function y =  isRgb(x)
    y = size(x, 3) == 3;
    if y
        if isa(x, 'logical')
            y = false;
        elseif isa(x, 'double')
            y = (min(x) >= 0 && max(x) <= 1);
        end
    end
end