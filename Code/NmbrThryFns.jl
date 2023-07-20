using Primes

# Table of Contents
# 	SET GLOBAL PRECISION (if you want to use L function of character)
#	Mobius fn
#	Sum of Divisors
#	Sum of Divisors to the s th power
#	Sum of Prime Divisors (see note)
#	Number of prime divisors
#	Number of prime power divisors


# Global Precision
# 	These aren't equivalent
global m = prevprime(2^8)
global ℙ = primes(m)

# Fix a branch of complex logarithm
l = log

# MOBIUS FN
#	Note all(1 .== values(factor(1))) = all(1 .== Int64[]) = all(Bool[]) = true
function μ(n::Integer)
	if all( 1 .== values(factor(n)) ) return (-1)^length(factor(n))
	else return 0
	end
end

# Sum of Divisors
function σ(n::Integer)
	return prod( [ (f[1]^(f[2]+1) - 1)/(f[1] - 1) for f in factor(n) ])
end
# Sum of Divisors to the s th power
function σ(z,n::Integer)
	return prod( [ ((f[1]^z)^(f[2]+1) - 1)/(f[1]^z - 1) for f in factor(n) ])
end

# Sum of Prime Divisors
#(technically, return arg if only arg and 1 divide arg else sum of prime divisors), but this function works because:
#	sum(keys(Dict(Pair{Number,Number}[]))) = sum(Number[]) = 0
function w(n::Integer)
	return sum(keys(factor(n)))
end
# Sum of z-powers of prime divisors
function w(z,n::Integer)
	return sum(keys(factor(n)) .^ z)
end

# Prime Divisors
# number of prime divisors
ω(n::Integer) =length(keys(factor(n)))
# sum of t-th power of prime divisors
ω(t,n::Integer) = sum(keys(factor(n)) .^ t)
# Number of primes powers dividing n, also Number of divisors d with ω(d) = 1
Ω(n::Integer) = sum(values(factor(n)))
# sum of 
Ω(t,n::Integer) = sum((keys(factor(n)) .^ t) .* values(factor(n)))

f(a,b,n) = sum((keys(factor(n)) .^ a) .* (values(factor(n)) .^ b) )

# L function of a character
# 	Note: This need not return a number, anything that accepts scalar multiplication is possible
function L(a::Function,s::Number)
	return prod( [ (1 - a(p)/p^s)^-1 for p in ℙ ] )
end

# L function of a aka (sometimes a "representation")
# 	Note: This need not return a number, anything that accepts scalar multiplication is possible
function L(A::Array{2},s::Number)
	if size(A)[1] == size(A)[2]
		dim = size(A)[1]
		return sum( [ sum([(A^n)[i,i] for i in 1:dim])/n^s for n in 1:m ] )
	else
		error("Matrix argument not square so can't take traces of powers :(")
	end
end






