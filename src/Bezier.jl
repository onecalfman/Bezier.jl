module Bezier

export bezier

# https://stackoverflow.com/questions/63892334/using-broadcasting-julia-for-converting-vector-of-vectors-to-matrices
function switch_dimensions(vec::AbstractVector{T}) where T <: AbstractVector
    dim1 = length(vec)
    dim2 = length(vec[1])
    vects = Vector{Vector}(undef, dim2)
    map(x -> vects[x] = Array{eltype(vec[1])}(undef, dim1), 1:dim2)
    @inbounds @fastmath for i in 1:dim1, j in 1:dim2
        vects[j][i] = vec[i][j]
    end
    return vects
end

# actual calculation for quadratic and cubic curves
bezier(p0 :: Vector, p1 :: Vector, p2 :: Vector,               t :: Real) = (1-t)^2 * ((1-t) * p0 + t * p1) + t * ((1-t) * p1 + t * p2)
bezier(p0 :: Vector, p1 :: Vector, p2 :: Vector, p3 :: Vector, t :: Real) = (1-t)^3 * p0 + 3 * (1-t)^2 * t * p1 + 3 * (1-t)*t^2 * p2 + t^3 * p3

# returns two lists with the x and y values for the given points
# it can be used for plotting like this:
#   plot(bezier([0,0],[1,0],[1,1])...)
bezier(p0 :: Vector, p1 :: Vector, p2 :: Vector;               range = 0:0.01:1) = map(t -> bezier(p0,p1,p2,t), range) |> switch_dimensions
bezier(p0 :: Vector, p1 :: Vector, p2 :: Vector, p3 :: Vector; range = 0:0.01:1) = map(t -> bezier(p0,p1,p2,p3,t), range) |> switch_dimensions

# accepts two lists of x and y values.
# The following produces the same result as the example above:
#   plot(bezier([0,1,1],[0,0,1])...)
bezier(r1 :: Vector, r2 :: Vector; range = 0:0.01:1) = bezier(([r1, r2] |> switch_dimensions)..., range = range)

end # module
