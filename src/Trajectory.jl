using Interpolations
"""
    getTVDSS(md::Float64, mds::Array{Float64}, tvds::Array{Float64})
Interpolates an array of MD, TVDSS and gives the tvdss at a desired depth"""
function getTVDSS(md::Float64, mds::Array{Float64},tvds::Array{Float64} )
    ipt = LinearInterpolation(mds, tvds)
    ko = ipt(md)
    return ko
end

"""
    getTemperature(md::Float64, mds::Array{Float64}, temps::Array{Float64})
Interpolates an array of MD, Temperature and gives the temperature at a desired depth
"""
function getTemperature(md::Float64, mds::Array{Float64}, temps::Array{Float64})
    ipt = LinearInterpolation(mds, temps)
    ko = ipt(md)
    return ko
end