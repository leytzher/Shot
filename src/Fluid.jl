
using Interpolations
include("UnitConversions.jl")


"""
    Fluid(gravityAPI::T, gasGravity::T, solutionGOR::T)

Creates a struct to represent a crude oil sample.
All properties must be given at standard conditions (60F, 14.5 psia)
"""
mutable struct Fluid{T}
    gravityAPI::T
    gasGravity::T
    solutionGOR::T
end

"""
    oilGravity(fluid::Fluid)

Computer the oil gravity using the API of the fluid.
"""
oilGravity(fluid::Fluid) = 141.5/(131.5+fluid.gravityAPI)


"""
    oilGravity(density::Float64)

Compute the oil gravity if density in lb/cuft is given
"""
oilGravity(density) = density/62.4

"""
    oilDensity(f::Fluid, temperature::Float64)

Compute the oil density in lb/cuft given a fluid and a temperature in Fahrenheit
"""
function oilDensity(fluid::Fluid, temperature)
    oilGrav = oilGravity(fluid)
    rs = fluid.solutionGOR
    gasGrav = fluid.gasGravity
    num = 62.4*oilGrav+0.0136*rs*gasGrav
    den = 0.972+0.000147*(rs*((gasGrav/oilGrav)^0.5)+(1.25*(temperature)))^1.175
    return num/den
end

"""
    adiabaticOilModulus(f::Fluid, temperature::Float64, pressure::Float64)

Compute the adiabatic oil modulus in psi using the Arco formula.
Temperature must be given in Fahrenheit.
Pressure must be given in psia
"""
function adiabaticOilBulkModulus(fluid::Fluid, temperature, pressure)
    a,b,c,d,e,f = 1.286e6, 13.55, 4.122e4, 4.53e3, 10.59, 3.228
    temp = fahrenhetToRankine(temperature)
    ka = a+b*pressure-c*(temp^0.5)-d*(fluid.gravityAPI)-e*(fluid.gravityAPI^2)+f*temp*(fluid.gravityAPI)
end

"""
    pressureGradient(density::Float64)

Compute the pressure gradient given a density in lb/cuft
"""
pressureGradient(density::Float64) = density/144.0

"""
    adiabaticWaterBulkModulus(temperature::Float, pressure::Float)

Calculates the adiabatic bulk modulus for water.
Temperature must be in Fahrenheit
Pressure must be in psia.
"""
function adiabaticWaterBulkModulus(temperature::Float64, pressure::Float64)
    tempArray = [32, 50, 68, 86, 104, 122, 140, 158, 176, 194, 212]
    kosArray = [289, 308, 323, 333, 340, 345, 348, 348, 341, 342, 336]
    ipt = LinearInterpolation(tempArray, kosArray)
    ko = ipt(temperature)
    return 1000*ko+3.4*pressure
end


"""
    gasDensity(fluid::Fluid, pressure::Float64, temperature::Float64)

Calculates gas density in lb/cuft.
pressure must be in psia
temperature must be in Fahrenheit
"""
function gasDensity(fluid::Fluid, pressure::Float64, temperature::Float64)
        ma = 28.96*fluid.gasGravity
        temp = fahrenhetToRankine(temperature)
        return (pressure*ma)/(10.73*temp)
end
