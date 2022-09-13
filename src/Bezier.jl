module Bezier

export bernstein, bezier, bernstein_polynomial, bezier_polynomial

using Symbolics

# scatter point
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

# polynomial function
bernstein_polynomial(n :: Integer, t :: Num, k :: Integer, w :: AbstractVector{S}) where {S <: Real} = binomial(n,k) * (1-t)^(n-k) * t^k * w[k+1]

function bernstein_polynomial(t :: Num, w :: AbstractVector{S}) where {S <: Real}
    n :: Integer = length(w) - 1
    mapreduce(k -> bernstein_polynomial(n,t,k,w), (a,b) -> a + b, 0:n)
end

bezier_polynomial(t :: Num, x :: AbstractVector{T}) where T <: Real = bernstein_polynomial(t, x)

bezier_polynomial(t :: Num, x :: AbstractVecOrMat{T}, y :: AbstractVecOrMat{S}) where {T,S <: Real} = (bezier_polynomial(t, x), bezier_polynomial(t, y))

bezier_polynomial(t :: Num, x :: AbstractMatrix{T}, y :: AbstractMatrix{S}) where {T,S <: Real} = bezier_polynomial(t, vec(x), vec(y))

function bezier_polynomial(t :: Num, x :: AbstractMatrix{T}) where T <: Real
	if size(x)[1] == 2
		bezier_polynomial(t, vec(x[1,:]),vec(x[2,:]))
	elseif size(x)[2] == 2
		bezier_polynomial(t, vec(x[:,1]),vec(x[:,2]))
	else
		throw(ArgumentError("unsupported matrix dimensions, needs to be 2xm or nx2"))
	end
end

end # module
