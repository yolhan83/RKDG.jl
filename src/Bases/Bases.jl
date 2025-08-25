"""
    AbstractBase{p}
An abstract type for polynomial bases of order `p`.
"""
abstract type AbstractBase{p} end

include("legendre.jl")
include("utils.jl")
include("gauss_lobatto.jl")