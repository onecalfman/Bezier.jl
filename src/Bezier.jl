module Bezier

export bezier

# This module generates Bezier curves of arbitrary degree.
# The degree of the Bezier curve is inferred from the number of control points.
#
# The nth-Degree bezier curve is generated with Bernstein-Polynomials.
# Since julia has a efficient binomial function, this generation,
# The maximum number of control points is 67. For larger numbers,
# a buffer overflow occurs in the binomial function.


# generates the Bernstein-Polynomials for a single tuple of values
bernstein(n :: Integer, t :: Real, k :: Integer, w :: Real) = binomial(n, k) * (1 - t)^(n - k) * t^k * w

# returns the sum of all Bernstein-Polynomials for a specific value of t ∊ [0,1]
bernstein_sum(t :: T, w :: AbstractVector{S}) where {T,S <: Number } = reduce((acc, k) -> acc + bernstein(length(w)-1,t,k-1,w[k]), 1:length(w))

# returns a vector with the points to draw a bezier curve on the specified range
bezier(w :: AbstractVector{T}; range = 0:0.01:1) where T <: Number = map(t -> bernstein_sum(t, w), range)

# returns a tuple of two vectors containing the points to draw the resulting bezier curve
# example:
#
# using Plots
# using Bezier
# plot(bezier([0,1,2,3],[-2,4,6,1]))
# plot(bezier([0,1,2,4//5,0.7,3,3],[-2,4,6,1,9,2,6]))
#

bezier(x :: AbstractVector{T}, y :: AbstractVector{S}; range = 0:0.01:1) where {T,S <: Number} = (length(x) == length(y)) ? (bezier(x, range = range), bezier(y, range = range)) : throw(ArgumentError("inputs are not of equal length"))
bezier(x :: AbstractMatrix{T}, y :: AbstractMatrix{S}; range = 0:0.01:1) where {T,S <: Number} = bezier(vec(x),vec(y), range = range)

end # module
