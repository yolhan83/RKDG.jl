function legendre(p::Int)
    if p == 0
        return Polynomial([1])
    elseif p == 1
        return Polynomial([0,1])
    else
        return ((2p - 1) * Polynomial([0,1]) * legendre(p - 1) - (p - 1) * legendre(p - 2)) / p
    end
end

