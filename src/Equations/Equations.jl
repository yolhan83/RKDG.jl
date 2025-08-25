"""
    abstract type AbstractEquation{D,N} end
An abstract type for equations in D dimensions with N variables.    
"""
abstract type AbstractEquation{D,N} end

"""
    flux(eq::AbstractEquation, u::AbstractArray,x ::AbstractArray, n ::Union{AbstractArray,Real}, t::Real)
Compute the flux for the equation `eq` given the state `u`, position `x`, normal vector `n`, and time `t`.    
"""
function flux(eq::AbstractEquation, u::AbstractArray,x ::AbstractArray, n ::Union{AbstractArray,Real}, t::Real)
    error("flux not implemented for $(typeof(eq))")
end

"""
    source(eq::AbstractEquation, u::AbstractArray,x ::AbstractArray, t ::Real)
Compute the source term for the equation `eq` given the state `u`, position `x`, and time `t`.
"""
function source(eq::AbstractEquation, u::AbstractArray,x ::AbstractArray, t ::Real)
    error("source not implemented for $(typeof(eq))") 
end

