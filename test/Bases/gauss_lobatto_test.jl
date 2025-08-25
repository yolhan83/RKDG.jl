using Test
using RKDG

@testset "GaussLobatto1D" begin
    L1 = GaussLobatto1D(1)
    L2 = GaussLobatto1D(2)
    L3 = GaussLobatto1D(3)
    L4 = GaussLobatto1D(4)
    @test L1.p == 1
    @test L2.p == 2
    @test L3.p == 3
    @test L4.p == 4
    @test length(L1.weights) == length(L1.points) == 1 + 1
    @test length(L2.weights) == length(L2.points) == 2 + 1
    @test length(L3.weights) == length(L3.points) == 3 + 1
    @test length(L4.weights) == length(L4.points) == 4 + 1
    L1.(L1.points,1) ≈ [i == 1 ? 1.0 : 0.0 for i in 1:length(L1.points)]
    L2.(L2.points,2) ≈ [i == 2 ? 1.0 : 0.0 for i in 1:length(L2.points)]
    L3.(L3.points,3) ≈ [i == 3 ? 1.0 : 0.0 for i in 1:length(L3.points)]
    L4.(L4.points,4) ≈ [i == 4 ? 1.0 : 0.0 for i in 1:length(L4.points)] 
    @test [derivative(L1,L1.points[j],i)*L1.weights[j] for i in 1:length(L1.points), j in 1:length(L1.points)] ≈ L1.D
    @test [derivative(L2,L2.points[j],i)*L2.weights[j] for i in 1:length(L2.points), j in 1:length(L2.points)] ≈ L2.D
    @test [derivative(L3,L3.points[j],i)*L3.weights[j] for i in 1:length(L3.points), j in 1:length(L3.points)] ≈ L3.D
    @test [derivative(L4,L4.points[j],i)*L4.weights[j] for i in 1:length(L4.points), j in 1:length(L4.points)] ≈ L4.D
end