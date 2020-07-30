using Shot
using Test

f = Fluid(10.0,0.1,0.1)



@testset "Shot.jl" begin
    # Write your tests here.
    @test oilGravity(f) == 1.0
end
