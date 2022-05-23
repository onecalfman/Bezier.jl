module Bezier

export bezier


bernstein(n :: Integer, t :: T,k :: Integer, w :: AbstractVector{S}) where {T,S <: Number} = binomial(n,k) * (1-t)^(n-k) * t^k * w[k+1]

bernstein(n,t,w) = mapreduce(k -> bernstein(n,t,k,w), (a,b) -> a + b, 0:n)

bezier(n :: Integer, t :: Float64, w :: AbstractVector{T}) where T <: Real = reduce(t -> bernstein(n,t,k,w), w)

bezier(x :: Vector{T}, range = 0:0.01:1) where T <: Real = map(t -> bernstein((x |> length) - 1, t, x), range)

bezier(x :: Vector{T}, y :: Vector{S}, range = 0:0.01:1) where {T,S <: Number} = (bezier(x, range), bezier(y, range))

bezier(x :: AbstractMatrix{T}, y :: AbstractMatrix{S}, range = 0:0.01:1) where {T,S <: Number} = bezier([x y], range)

function bezier(x :: AbstractMatrix{T}, range = 0:0.01:1) where T <: Number
	if size(x)[2] == 2
		bezier(vec(x[1,:]),vec(x[2,:]), range)
	elseif size(x)[1] == 2
		bezier(vec(x[:,1]),vec(x[:,2]), range)
	else
		throw(ArgumentError("unsupported matrix dimensions"))
	end
end

end # module
