function result = CharRecompose(A)
global D;
index = A(1,2:end);
tmp = A(1,1);
result = [tmp];
[m,n] = size(index);
while n>=2
    len = D(tmp,index(1));
    tmpID = 1;
    for s = 2:n
        if len > D(tmp,index(s))
            tmpID = s;
            len = D(tmp,index(s));
        end
    end
    tmp = index(tmpID);
    result = [result,tmp];
    index(:,tmpID) = [];
    [m,n] = size(index);
end
result = [result,index(1)];
