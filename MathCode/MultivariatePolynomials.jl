import Base.:+

# D stands for number of variables
# F stands for field

struct Monomial{D,F}
	pwrs::NTuple{D,<:Integer}
	coeff::F
end

struct Polynomial{D,F}
	parts::Vector{Monomial{D,F}}
end

function +(A::Monomial{D,F},B::Monomial{D,F}) where {D,F<:Number}
	if A.pwrs==B.pwrs return Monomial(A.pwrs, sum([A.coeff,B.coeff]))
	else return Polynomial(vcat(A,B))
	end
end

(m::Monomial{D,F})(x::Vararg{F,D}) where {D,F<:Number} = m.coeff*prod(x .^ m.pwrs) 
(p::Polynomial{D,F})(x::Vararg{F,D}) where {D,F<:Number} = mapreduce(m->m(x),+,p.parts)

Monomial(I::CartesianIndex) = Monomial(1,ntuple(i->count(==(i),Tuple(I)),length(I)))
Monomial(c,I::CartesianIndex) = Monomial(c,ntuple(i->count(==(i),Tuple(I)),length(I)))
function Polynomial(T::Array{F,D}) where {F<:Number,D}
	d = ndims(T) 
	supp = findall(!=(0),T)
	seen = NTuple[]
	basis = Dict()
	for I in supp
		term = ntuple(i->count(==(i),Tuple(I)),d)
		if term in seen
			basis[term] += T[I]
		else
			basis[term] = T[I]
			push!(seen,term)
		end
	end
	v = vec(map(t->Monomial(basis[t],t),seen))
	return v
end

