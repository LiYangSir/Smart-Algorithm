function [A, B] = cross(A ,B)
    L = length(A);
    r1 = randsrc(1, 1, [1: L]);
    r2 = randsrc(1, 1, [1:L]);
    if r1~=r2
        a0 = A;b0 = B;
        s = min(r1, r2);
        e = max(r1, r2);
        for i = s: e
            a1 = A; b1 = B;
            A(i) = b0(i);
            B(i) = a0(i);
            x = find(A == A(i));
            y = find(B == B(i));
            i1 = x(x ~= i);
            i2 = y(y ~= i);
            if ~isempty(i1)
                A(i1) = a1(i);
            end
            if ~isempty(i2)
                B(i2) = b1(i);
            end
        end
    end
%         cpoint = 0;
%         while cpoint == 0
%             cpoint = round(rand*length(A));  % ΩªªªŒª÷√
%         end
%         fprintf('%d \n', cpoint);
%         x = find(A == B(1, cpoint));
%         y = find(B == A(1, cpoint));
%         [A(1, cpoint), B(1, cpoint)] = exchange(A(1, cpoint), B(1, cpoint));
%         [A(1, x), B(1, y)] = exchange(A(1, x), B(1, y));
end
