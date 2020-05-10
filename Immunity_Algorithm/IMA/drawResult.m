function drawResult(Image, threshold)
    [m, n] = size(Image);
    for i = 1: m
        for j = 1: n
            if Image(i, j) > threshold
                Image(i, j) = 255;
            else
                Image(i, j) = 0;
            end
        end
    end
    imshow(Image);
end
