using RKDG
using Documenter

DocMeta.setdocmeta!(RKDG, :DocTestSetup, :(using RKDG); recursive = true)

const page_rename = Dict("developer.md" => "Developer docs") # Without the numbers
const numbered_pages = [
    file for file in readdir(joinpath(@__DIR__, "src")) if
    file != "index.md" && splitext(file)[2] == ".md"
]

makedocs(;
    modules = [RKDG],
    authors = "yolhan <yolhan@laposte.net>",
    repo = "https://github.com/yolhan83/RKDG.jl/blob/{commit}{path}#{line}",
    sitename = "RKDG.jl",
    format = Documenter.HTML(; canonical = "https://yolhan83.github.io/RKDG.jl"),
    pages = ["index.md"; numbered_pages],
)

deploydocs(; repo = "github.com/yolhan83/RKDG.jl")
