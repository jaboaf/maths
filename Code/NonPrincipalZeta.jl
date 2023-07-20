using Plots
using Primes

n = 200; 
N = collect(1:n);
P = primes(n);
q = 1//P[end];
const i = im;

# p-branch of Log
l(p) = log(p) + 2*pi*i*p

# Euler Product
# "p^-s" = exp(-s*l(p)) = exp(-s*(log(p) + 2*pi*i*p)) = exp(-slog(p) + -s*2*pi*i*p) = p^-s * exp(-s*2*pi*i*p)
Z(s::Number) = prod( 1 ./ (1 .- exp.(-s*l.(P)) ) )

# "Domain"
D = vcat( vec([ b  .+ collect(1//p:1//p:(p-1)//p) for b in 0:1, p in P])... )
sort!(D)
D_0 = filter(<(1),D)

# { Z(s) | s ∈ q:q:1//q }
