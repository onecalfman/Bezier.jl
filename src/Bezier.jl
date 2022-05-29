module Bezier

export bezier

bernstein(n :: Integer, t :: T, k :: Integer, w :: AbstractVector{S}) where {T,S <: Real} = binomial(n,k) * (1-t)^(n-k) * t^k * w[k+1]

function bernstein(t :: T, w :: AbstractVector{S}) where {T,S <: Real}
    n :: Integer = length(w) - 1
    mapreduce(k -> bernstein(n,t,k,w), (a,b) -> a + b, 0:n)
end

bezier(x :: AbstractVector{T}, range :: StepRangeLen = 0:0.01:1) where T <: Real = map(t -> bernstein(t, x), range)

bezier(x :: AbstractVecOrMat{T}, y :: AbstractVecOrMat{S}, range :: StepRangeLen = 0:0.01:1) where {T,S <: Real} = (bezier(x, range), bezier(y, range))

bezier(x :: AbstractMatrix{T}, y :: AbstractMatrix{S}, range :: StepRangeLen = 0:0.01:1) where {T,S <: Real} = bezier(vec(x), vec(y), range)

function bezier(x :: AbstractMatrix{T}, range :: StepRangeLen = 0:0.01:1) where T <: Real
	if size(x)[1] == 2
		bezier(vec(x[1,:]),vec(x[2,:]), range)
	elseif size(x)[2] == 2
		bezier(vec(x[:,1]),vec(x[:,2]), range)
	else
		throw(ArgumentError("unsupported matrix dimensions, needs to be 2xm or nx2"))
	end
end

end # module
