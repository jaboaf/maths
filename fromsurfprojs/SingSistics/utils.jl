import Base.+
import Base.*

struct FiniteSuppFn{It,Vt}
	D::Dict{It,Vt}
end

# why not just
#=
struct SuppFn{DT,VT}
	D::Array{DT}
	R::Array{VT}
end

=#

#FiniteSuppFn(D::Dict{It,Vt}) where {It,Vt}= FiniteSuppFn(filter(p->p.last != zero(Vt),))
# if i is in index set return D[i] else return 0
# i ∈ F.D ? F.D[i] : zero(Vt)
Base.getindex(F::FiniteSuppFn{It,Vt},i::It) where {It,Vt} = if i in keys(F.D) F.D[i] else zero(Vt) end

# if y is not 0 then let D[x] = y
Base.setindex!(F::FiniteSuppFn{It,Vt},y::Vt,x::It) where {It,Vt} = if !(iszero(y)) F.D[x] = y end
# If 

Base.getindex(F::FiniteSuppFn{It,Vt},I::Vector{It}) where {It,Vt} = map(F[i],I)
Base.getindex(F::FiniteSuppFn{It,Vt},I::Set{It}) where {It,Vt} = map(i->get(F.D, i, zero(Vt)),I)

function +(A::FiniteSuppFn{It,Vt},B::FiniteSuppFn{It,Vt}) where {It,Vt}
	if A.D.count >= B.D.count
		+(B,A)
	else
		for k in union(A.D.keys,B.D.keys) A.D[k] += B[k] end
	end
end
function *(A::FiniteSuppFn{It,Vt},B::FiniteSuppFn{It,Vt}) where {It,Vt}
	if A.D.count >= B.D.count
		*(B,A)
	else
		# I should remove A.D.keys\B.D.keys from A.D
		for k in union(A.D.keys,B.D.keys) A.D.keys[k] *= B[k] end
	end
end

# inv(A::FiniteSuppFn{It,Vt}) where {It,Vt} = Dict([])


# Frequency map
# function freqmap(A::Vector{T})
#=
option1:
	U = unique(A)
	C = map(u->count(==(u),A),U)
	return [U[findall(==(c),C)] for c in 1:length(A)]
option 2:
	f = ntuple(k->eltype(A)[],length(A))
	for u in unique(A) push!(f[count(==(u),A)],u) end
	return f
option 3:
	[ findall(u->count(==(u),A)==f,unique(A)) for f in 1:length(A) ]
=#

function freqcount(A::Vector{T})
	z = zeros(Int,length(A))
	for u in unique(A) z[count(==(u))]
	

