module Bezier

export bezier

Matrix(vv :: AbstractVector{T}) where T <: AbstractVector = mapreduce(permutedims, vcat, vv)
transpose(vv :: AbstractVector{T}) where T <: AbstractVector = vv |> Matrix |> eachcol |> collect

# actual calculation for quadratic
bezier(p0 :: Vector, p1 :: Vector, p2 :: Vector, t :: Real) =
  (1-t)^2 * ((1-t) * p0 + t * p1) + t * ((1-t) * p1 + t * p2)

# for cubic
bezier(p0 :: Vector, p1 :: Vector, p2 :: Vector, p3 :: Vector, t :: Real) =
  (1-t)^3 * p0 + 3 * (1-t)^2 * t * p1 + 3 * (1-t)*t^2 * p2 + t^3 * p3

# returns two lists with the x and y values for the given points
# it can be used for plotting like this:
#   plot(bezier([0,0],[1,0],[1,1])...)
function bezier(p0 :: Vector, p1 :: Vector, p2 :: Vector; range = 0:0.01:1)
	map(t -> bezier(p0,p1,p2,t), range) |> transpose
end

function bezier(p0 :: Vector, p1 :: Vector, p2 :: Vector, p3 :: Vector; range = 0:0.01:1)
	map(t -> bezier(p0,p1,p2,p3,t), range) |> transpose
end

# accepts two lists of x and y values.
# The following produces the same result as the example above:
#   plot(bezier([0,1,1],[0,0,1])...)
function bezier(r1 :: Vector, r2 :: Vector; range = 0:0.01:1)
	bezier(([r1, r2] |> transpose)..., range = range)
end

end # module
