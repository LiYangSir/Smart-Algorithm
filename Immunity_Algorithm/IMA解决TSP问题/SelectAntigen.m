function result = SelectAntigen(A,B)
global D;
[m,n] = size(A);
[p,q] = size(B);
index = [A;B];
rr = zeros((m+p),2);
rr(:,2) = [1:(m+p)]';
for s = 1:(m+p)
    for t = 1:(n-1)
        rr(s,1) = rr(s,1)+D(index(s,t),index(s,t+1));
    end
    rr(s,1) = rr(s,1) + D(index(s,n),index(s,1));
end
rr = sortrows(rr,1);
ss = [];
tmplen = 0;
for s = 1:(m+p)
    if tmplen ~= rr(s,1)
        tmplen = rr(s,1);
        ss = [ss;index(rr(s,2),:)];
    end
end
global TmpResult;
TmpResult = [TmpResult;rr(1,1)];
global TmpResult1;
TmpResult1 = [TmpResult1;rr(end,1)];
result = ss(1:m,:);
