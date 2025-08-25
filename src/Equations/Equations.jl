"""
    abstract type AbstractEquation{D,N} end
An abstract type for equations in D dimensions with N variables.    
"""
abstract type AbstractEquation{D,N} end

"""
    flux(eq::AbstractEquation, u::AbstractArray,x ::AbstractArray, n ::Union{AbstractArray,Real}, t::Real)
Compute the flux for the equation `eq` given the state `u`, position `x`, normal vector `n`, and time `t`.    
"""
function flux(eq::AbstractEquation{D,N}, u::AbstractArray{N},x ::AbstractArray{D}, n ::AbstractArray{D}, t::Real) where {D,N}
    error("flux not implemented for $(typeof(eq))")
end
function flux(eq::AbstractEquation{1,N}, u::AbstractArray{N},x ::Real, t::Real) where {N}
    error("flux not implemented for $(typeof(eq))")
end

"""
    source(eq::AbstractEquation, u::AbstractArray,x ::AbstractArray, t ::Real)
Compute the source term for the equation `eq` given the state `u`, position `x`, and time `t`.
"""
function source(eq::AbstractEquation{D,N}, u::AbstractArray{N},x ::AbstractArray{D}, t ::Real) where {D,N}
    error("source not implemented for $(typeof(eq))") 
end
function source(eq::AbstractEquation{1,N}, u::AbstractArray{N},x ::Real, t ::Real) where {N}
    error("source not implemented for $(typeof(eq))") 
end

"""
    maxspeed(eq::AbstractEquation, ul::AbstractArray, ur::AbstractArray,x ::AbstractArray, n ::Union{AbstractArray,Real}, t ::Real)
Compute the maximum wave speed for the equation `eq` given the left and right states `ul` and `ur`, position `x`, normal vector `n`, and time `t`.
"""
function maxspeed(eq::AbstractEquation{D,N}, ul::AbstractArray{N}, ur::AbstractArray{N},x ::AbstractArray{D}, n ::AbstractArray{D}, t::Real) where {D,N}
    error("maxspeed not implemented for $(typeof(eq))")
end
function maxspeed(eq::AbstractEquation{1,N}, ul::AbstractArray{N}, ur::AbstractArray{N},x ::Real, t::Real) where {N}
    error("maxspeed not implemented for $(typeof(eq))")
end

"""
    lax(eq::AbstractEquation, ul::AbstractArray, ur::AbstractArray,x ::AbstractArray, n ::Union{AbstractArray,Real}, t ::Real)
    Compute the Lax flux for the equation `eq` given the left and right states `ul` and `ur`, position `x`, normal vector `n`, and time `t`.
"""
function lax(eq::AbstractEquation{D,N}, ul::AbstractArray{N}, ur::AbstractArray{N},x ::AbstractArray{D}, n ::AbstractArray{D}, t::Real) where {D,N}
    0.5 .* (flux(eq,ul,x,n,t) .+ flux(eq,ur,x,n,t) .- maxspeed(eq,ul,ur,x,n,t).*(ur .- ul))
end
function lax(eq::AbstractEquation{1,N}, ul::AbstractArray{N}, ur::AbstractArray{N},x ::Real, n::Real, t::Real) where {N}
    0.5 .* ( n .* (flux(eq,ul,x,t) .+ flux(eq,ur,x,t)) .- maxspeed(eq,ul,ur,x,t).*(ur .- ul))
end
