include("stochasticsimulation.jl")
include("quadrature.jl")
using Plots

# Demere
num = 100
for i in 1:10
    prob = demere(num)
    print(prob)
    print("\t")
end
print("\n")

# Demere
num = 100000
for i in 1:10
    prob1 = demere(num)
    print(prob1)
    print("\t")
end
print("\n")

# roulette example
prob2 = roulette(8, 23, 10000)
println(prob2)

# hit and miss monte carlo method
f(x) = exp(-x)
val = hitmiss(f)
println(val)

# crude monte carlo method
val = crudemc(f)
println(val)

# compare with standard method
N = 10 .^ (3:6)
fexact = 1.0 - exp(-1.0)
hmerr = []
mcerr = []
trerr = []
box = [0;1]
for i in N
    append!(hmerr,abs(hitmiss(f, box, i)-fexact))
    append!(mcerr,abs(crudemc(f, box, i)-fexact))
    append!(trerr,abs(ctr(f, box, i)-fexact))
end


# Plot the errors
pgfplotsx();
plot(N, hmerr, xaxis=:log, yaxis=:log)
plot!(N, mcerr, xaxis=:log, yaxis=:log)
plot!(N, trerr, xaxis=:log, yaxis=:log,linestyle = :dot,linealpha = 0.5, linewidth = 4, linecolor=:red)