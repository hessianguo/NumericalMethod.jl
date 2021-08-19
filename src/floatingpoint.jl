include("quadrature.jl")
# forward recurrence
I = log(3.0/2.0)
for n in 1:100
    global I = 1.0/n - 2.0*I
end
println(I)

# backward recurrence
I = 1.0/200
for n in 200:-1:101
    global I = 1.0/(2.0*n) - I/2
end
println(I)

# check result
f(x) = x^100/(x+2)
q = ctr(f)
println(q)
