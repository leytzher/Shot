mutable struct Fluid{T}
    gravityAPI::T
    gasGravity::T
    solutionGOR::T
end

oilGravity(fluid::Fluid) = 141.5/(131.5+fluid.gravityAPI)
