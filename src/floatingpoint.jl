include("quadrature.jl")
# forward recurrence
I1 = log(3.0/2.0)
for n in 1:100
    global I1 = 1.0/n - 2.0*I1
end
println(I)

# backward recurrence
I1 = 1.0/200
for n in 200:-1:101
    global I1 = 1.0/(2.0*n) - I1/2
end
println(I1)

# check result
f(x) = x^100/(x+2)
q = ctr(f)
println(q)
