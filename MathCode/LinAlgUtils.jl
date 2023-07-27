function per(A::Matrix)
	if size(A)==(1,1) return A[1,1]
	else return sum([ A[1,i]*det( A[axes(A)[1][2:end],setdiff(axes(A)[2],[i])] ) for i in filter(i->A[1,i]!=0,axes(A)[2]) ])
	end
end