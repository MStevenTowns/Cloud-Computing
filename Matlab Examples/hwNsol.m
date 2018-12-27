% Problem 1

% Problem 2
n = 1e6;
a = randn(n,2);
b = randn(n,2);
c = 0;
for i = 1:20
    c = (a(i,1)-b(i,1))^2 + (a(i,2)-b(i,2))^2;
end
c = sqrt(c);

