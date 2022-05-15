# Bezier.jl
a minimal implementation of bezier curves in julia

### Examples

Return two lists with the x and y values for the quadratic bezier curve that
spans from (0,0) to (1,1) with the controll point (0,1);

```julia
  bezier([0,0],[0,1],[1,1])
```

Return a cubic bezier curve with an added controll point at (0,1):

```julia
  bezier([0,0],[0,1],[0,1],[1,1])
```

It is also possible to use two vectors, containing the x and y coordinates, as input.
The following example is equivalent to the example above:

```julia
  bezier([0,0,0,1],[0,1,1,1])
```

#### Plotting
The number of coordinates is 100 by default, but can be modified with the range keyword.

```julia
  using Plots, Bezier

  plot(bezier([0,0],[0.5,1.8],[1,0])...,)
  plot!(bezier([0,0,1,1],[0,1,-1,0.5])...)
  plot!(bezier([0,0,1,1],[0,1,-1,0.5], range=0:0.2:1)...)
```
![example plot](example.svg)
