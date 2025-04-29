using Test
using Bezier

@testset "Endpoints" begin 
    control_xs = [0,1,0]
    control_ys = [0,1,1]
    x, y = bezier(control_xs, control_ys)
    @test x[1] == control_xs[1]
    @test y[1] == control_ys[1]
    @test x[end] == control_xs[end]
    @test y[end] == control_ys[end]

    control_xs = [0,0,0,1]
    control_ys = [0,1,1,1]
    x, y = bezier(control_xs, control_ys)
    @test x[1] == control_xs[1]
    @test y[1] == control_ys[1]
    @test x[end] == control_xs[end]
    @test y[end] == control_ys[end]
end

@testset "Midpoint in cubic" begin 
    control_xs = [0,1/3,2/3,1]
    control_ys = [0,1/3,-1/3,0]
    x, y = bezier(control_xs, control_ys, 0.0:0.25:1.0)
    @test length(x) == length(y) == length(0.0:0.25:1.0)
    @test x[3] == 0.5
    @test y[3] == 0.0
    @test y[2] == -y[4]
end

