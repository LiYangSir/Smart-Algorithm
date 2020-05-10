function result = Mutation(A, P)
[m,n] = size(A);
%×Ö·û»»Î»
n1 = round(P(1)*m);
m1 = randperm(m);
cm1 = randperm(n-1)+1;
B1 = zeros(n1,n);
c1 = cm1(n-1);
c2 = cm1(n-2);
for s = 1:n1
    B1(s,:) = A(m1(s),:);
    tmp = B1(s,c1);
    B1(s,c1) = B1(s,c2);
    B1(s,c2) = tmp;
end

%%
%×Ö·û´®ÒÆÎ»
n2 = round(P(2)*m);
m2 = randperm(m);
cm2 = randperm(n-1)+1;
B2 = zeros(n2,n);
c1 = min([cm2(n-1),cm2(n-2)]);
c2 = max([cm2(n-1),cm2(n-2)]);
for s = 1:n2
    B2(s,:) = A(m2(s),:);
    B2(s,c1:c2) = DisplaceStr(B2(s,:),c1,c2);
end

%%
%×Ö·û´®Äæ×ª
n3 = round(P(3)*m);
m3 = randperm(m);
cm3 = randperm(n-1)+1;
B3 = zeros(n3,n);
c1 = min([cm3(n-1),cm3(n-2)]);
c2 = max([cm3(n-1),cm3(n-2)]);
for s = 1:n3
    B3(s,:) = A(m3(s),:);
    tmp1 = [[c2:-1:c1]',B3(s,c1:c2)'];
    tmp1 = sortrows(tmp1,1);
    B3(s,c1:c2) = tmp1(:,2)';
end

%%
%×Ö·ûÖØ×é
n4 = round(P(4)*m);
m4 = randperm(m);
cm4 = randperm(n-1)+1;
B4 = zeros(n4,n);
c1 = min([cm4(n-1),cm4(n-2)]);
c2 = max([cm4(n-1),cm4(n-2)]);
for s = 1:n4
    B4(s,:) = A(m4(s),:);
    B4(s,c1:c2) = CharRecompose(B4(s,c1:c2));
end

%%
%
result = [B1;B2;B3;B4];
