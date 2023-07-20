using Primes
using Plots

global m = 1000
global N = 1:m


# N term approximation to log(1/p)
asymAprxLog(p,n) = cumsum(((mod.(1:n,p) .== 0) *p .- 1) ./ (1:n))

# Faster than p -> ((mod.(N,p) .== 0) *p .- 1) ./ N
function trmsLog(p)
	T = -1 ./ N
	T[p:p:end] .+= (1 ./ (1:fld(m,p)))
	return T
end
# Faster than p -> cumsum( ((mod.(N,p) .== 0) *p .- 1) ./ N )
prtsmsLog(p) = cumsum(trmsLog(p))


ANIM = @animate for n in N[2:end]
	plot(
		hcat(asymAprxLog.(primes(n),n)...),
		legend=false,
		color_palette=palette(:roma, length(primes(p)) ),
		title="$n term approximation to log(1/p) for the $(length(primes(n))) primes less than $n)" )
end
gif(ANIM, "partialLogOfPrimes_1.gif",fps=15)

# 
termsLi(s,p) = exp.(2*pi*im*mod.(N,p) /p) ./ (N .^ s)
Li(s,p) = cumsum(termsLi(s,p))

termsLi(s,p,k) = exp.(2*pi*im*mod.(k*N,p) /p) ./ (N .^ s)
Li(s,p,k) = cumsum(termsLi(s,p,k))

sum(termsLi(s,p) = exp.(2*pi*im*mod.(1:N,p) /p) ./ ((1:N) .^ s))

