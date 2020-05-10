function result = DisplaceStr(inMatrix, startCol, endCol)
[m,n] = size(inMatrix);
if n <= 1
    result = inMatrix;
    return;
end
switch nargin
    case 1
        startCol = 1;
        endCol = n;
    case 2
        endCol = n;
end
mMatrix1 = inMatrix(:,(startCol + 1):endCol);
result = [mMatrix1, inMatrix(:, startCol)];
