using Documenter
using Bezier

makedocs(
    sitename = "Bezier",
    format = Documenter.HTML(),
    modules = [Bezier]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
