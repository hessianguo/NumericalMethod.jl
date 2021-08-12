include("stochasticsimulation.jl")

numReps = 100

for i in 1:10
    prob = demere(numReps)
    print(prob)
    print("\t")
end

print("\n")

numReps = 100000
for i in 1:10
    prob1 = demere(numReps)
    print(prob1)
    print("\t")
end
print("\n")

prob2 = roulette(8, 23, 10000)
println(prob2)