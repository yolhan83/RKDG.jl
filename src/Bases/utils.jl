function _build_points(p::Int,T::Type = Float64)
    points = T[-1.0]
    P = legendre(p)
    Pp = Polynomials.derivative(P)
    Ppr = Polynomials.roots(Pp) |> sort .|> T
    append!(points,Ppr)
    push!(points,T(1.0))
    return points
end

function _build_poly(n::Int,T::Type = Float64)
    points= _build_points(n)
    lagrange_polys = Polynomial{T,:x}[]
    for i in eachindex(points)
        numer = Polynomial(T[1.0])
        denom = T(1.0)
        xi = points[i]
        for j in eachindex(points)
            if j != i
                numer *= Polynomial(T[-points[j], 1.0])
                denom *= (xi - points[j])
            end
        end
        push!(lagrange_polys, numer / denom)
    end
    return lagrange_polys
end
