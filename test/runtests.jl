using Shot
using Test
include("Fluid.jl")
include("UnitConversions.jl")


f = Fluid(50.0,0.7796,650.0)
f2 = Fluid(35.0, 0.77, 650.0)
oilDensity(f,180)
adiabaticOilModulus(f2,80.0, 1000.0 )

oilGravity(f)
@testset "Shot.jl" begin
    # Write your tests here.
    @test oilGravity(f) == 0.7796143250688705
    @test oilGravity(62.4) == 1.0
    @test fahrenhetToRankine(60) == 520
    @test rankineToFahrenheit(520) == 60
    @test oilDensity(f,180)== 39.87351190240599
    @test adiabaticOilModulus(f2, 80.0,1000.0 )==231170.2088159817

end
