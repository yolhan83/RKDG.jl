module RKDG
using Polynomials

include("Equations/Equations.jl")
include("Bases/Bases.jl")
export AbstractEquation, flux, source,AbtsractBase, GaussLobatto1D, derivative
end
