%‘§¥¶¿Ì
function result = DisplaceInit(A)
[m,n] = size(A);
tmpCol = 0;
for col = 1:n
    if A(1,col) == 1
        tmpCol = col;
        break;
    end
end
if tmpCol == 0
    result = [];
else
    result = [A(1,tmpCol:n), A(1,1:(tmpCol-1))];
end
