using Primes

global N = 2^16
prm = primes(N)
mrp(p::Int) = findfirst(==(p),prm)

function D(K::Int)
	prmK = primes(K)
	mrpK(p::Int) = findfirst(==(p),prmK)
	A = zeros(Int16,length(prmK))
	for k in 1:K
		for p in factor(Array{Int},k) A[mrpK(p)] += 1 end
	end
	return A
end
d = D(N)

x = collect(1:N)
y = zeros(Int,N)
y[prm] = d

plot(x,y)
#plot(x,y, size=(800,200) )
#plot(x,1 ./ y, size=(800,200) )

function L(A)
	B = zeros(Int16,maximum(A))
	for a in A
		if a != 0
			for p in factor(Array{Int},a) B[mrp(p)] += 1 end
		end
	end
	return B
end

