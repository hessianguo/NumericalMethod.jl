include("differentiation.jl")
using Plots

h = 2.0 .^ (-2:-1:-52)
ffderr = []
bfderr = []
cfderr = []
f(x) = exp(x)
x = 1.0
dfexact = exp(1.0)
for h0 in h
    append!(ffderr, abs(ffd(f, x, h0 )-dfexact))
    append!(bfderr, abs(bfd(f, x, h0 )-dfexact))
    append!(cfderr, abs(cfd(f, x, h0 )-dfexact))
end

plot(h, ffderr, xaxis=:log, yaxis=:log)
plot!(h, bfderr, xaxis=:log, yaxis=:log)
plot!(h, cfderr, xaxis=:log, yaxis=:log)