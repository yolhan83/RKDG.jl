"""
    GaussLobatto1D{T,n}(p::Int; T::Type = Float64) <: AbstractBase{p}
A Lagrange polynomial basis on the Gauss-Lobatto points of order `p`
with element type `T`.
# Fields
- `p::Int`: Polynomial degree
- `weights ::Vector{T}`: Weights for quadrature
- `invweights ::Vector{T}`: Inverse of weights
- `points ::Vector{T}`: Quadrature points
- `coefs ::Vector{Vector{T}}`: Polynomial coefficients
- `D ::Matrix{T}`: Derivative matrix ϕ_j(points_i)
# methods
- `(L::GaussLobatto1D{n})(x ::Real,i ::Int)`: Evaluate the i-th basis function at x
- `derivative(L::GaussLobatto1D{n},x ::Real,i ::Int)`: Evaluate the derivative of the i-th basis function at x
"""
struct GaussLobatto1D{T,n} <: AbstractBase{n}
    p::Int # Polynomial order
    weights ::Vector{T} # Weights for quadrature
    invweights ::Vector{T} # Inverse of weights
    points ::Vector{T} # Quadrature points
    coefs ::Vector{Vector{T}} # Polynomial coefficients
    D ::Matrix{T} # Derivative matrix ϕ_j(points_i)
    function GaussLobatto1D(n,weights,invweights,points,coefs,D)
        return new{eltype(weights),n}(n-1,weights,invweights,points,coefs,D)
    end
end

function GaussLobatto1D(p::Int,T::Type = Float64)
    n = p+1
    points = _build_points(p,T)
    polys = _build_poly(p,T)
    weights = T[Polynomials.integrate(polys[i],-1.0,1.0) for i in eachindex(polys)]
    invweights = T[1/w for w in weights]
    D = T[Polynomials.derivative(polys[i])(points[j])*weights[j] for i in eachindex(points), j in eachindex(polys)]
    return GaussLobatto1D(n,weights,invweights,points,coeffs.(polys),D)
end

@fastmath function (L::GaussLobatto1D{T,n})(x ::Real,i ::Int) where {T,n}
     coefs = L.coefs[i]
    res = zero(x)
    xj = one(x)
    for j in 1:n
        res += coefs[j]*xj
        xj *= x
    end
    return res
end

@fastmath function derivative(L::GaussLobatto1D{T,n},x ::Real,i ::Int) where {T,n}
     coefs = L.coefs[i]
    res = zero(x)
    xj = one(x)
     for j in 2:n
        res += (j-1)*coefs[j]*xj
        xj *= x
    end
    return res
end