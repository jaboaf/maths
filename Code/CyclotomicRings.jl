using Plots
using Primes

Z(p) = collect(0:p-1); # {0,...,p-1}
Z_x(p) = collect(1:p-1); # {1,...,p-1}

C(p) = exp.(2*pi*im* Z(p)/p); # 1^(1/p)
C_x(p) = exp.(2*pi*im* Z_x(p)/p); # 1^(1/p) - {1}

g(p) = Int8[ mod(c,p)==r-1 for r in 1:p,c in 1:p];
j(p) = Int8[ c==p-1 ? -1 : mod(c,p)==r-1 for r in 1:p-1,c in 1:p-1];

G(p) = map(n->g(p)^n, 0:p-1)
J(p) = map(n->j(p)^n, 0:p-1)

L(p)= vec(map(x-> sum( C_x(p) .* x), Base.product(repeat([0:1],p-1)...)))
L_x(p)= L(p)[2:end]

scatter(L(p),aspect_ratio=1)