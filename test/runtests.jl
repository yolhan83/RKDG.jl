using RKDG
using Test

@testset "RKDG.jl" begin
    @test RKDG.hello_world() == "Hello, World!"
end
