# N is the number of variables

struct Monomial{D,R}
	coeff::R
	pwrs::NTuple{D,<:Integer}
end
(m::Monomial{D,R})(x::Vararg{R,D}) where {D,R<:Number} = m.coeff*prod(x.^ m.pwrs) 

struct Polynomial{D,R}
	parts::Vector{Monomial{D,R}}
end
(p::Polynomial{D,R})(x::Vararg{R,D}) where {D,R<:Number} = mapreduce(m->m(x),+,p.parts)

Monomial(I::CartesianIndex) = Monomial(1,ntuple(i->count(==(i),Tuple(I)),length(I)))
Monomial(c,I::CartesianIndex) = Monomial(c,ntuple(i->count(==(i),Tuple(I)),length(I)))
function Polynomial(T::Array{R,D}) where {R<:Number,D}
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

function Polynomial(T::Array{R,D}) where {R<:Number,D}
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