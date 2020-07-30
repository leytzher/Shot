include("../src/UnitConversions.jl")
include("../src/Fluid.jl")
include("../src/Tubing.jl")

using Shot
using Test


f = Fluid(50.0,0.65,650.0)
f2 = Fluid(35.0, 0.77, 650.0)



@testset "Shot" begin
    # Write your tests here.
    @test oilGravity(f) == 0.7796143250688705
    @test oilGravity(62.4) == 1.0
    @test fahrenhetToRankine(60) == 520
    @test rankineToFahrenheit(520) == 60
    @test oilDensity(f,180.0)== 39.961609859419426
    @test adiabaticOilBulkModulus(f2, 80.0,1000.0 )==231170.2088159817
    @test pressureGradient(62.4) == 0.43333333333333335
    @test adiabaticWaterBulkModulus(150.0, 1000.0) == 351400.00
    @test gasDensity(f, 1500.0, 150.0) == 4.3139351901364344
    @test psiFactor(0.1,0.01,0.3,1) == 1.1236363636363635
    @test psiFactor(0.1,0.01,0.3,2) == 1.069090909090909
    @test psiFactor(0.1,0.01,0.3,3) == 1.1690909090909092
end
