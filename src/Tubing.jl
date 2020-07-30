function psiFactor(diameter::Float64, wallThickness::Float64,poissonRatio::Float64, caseID::Int64)
    if caseID==1
        psi = (1/(1+wallThickness/diameter))*(5/4-poissonRatio+2*(wallThickness/diameter)*(1+poissonRatio)*(1+wallThickness/diameter))
    elseif caseID==2
    	psi=  (1/(1+wallThickness/diameter))*(1-(poissonRatio^2)+2*(wallThickness/diameter)*(1+poissonRatio*(1+wallThickness/diameter)))
    elseif caseID==3
        psi = (1/(1+wallThickness/diameter))*(1+2*(wallThickness/diameter)*(1+poissonRatio)*(1+wallThickness/diameter))
    end
    return psi
end
