include("linearsystem.jl")
using BenchmarkTools

function tbt(δ)
    u22 = 1.0 - 1.0/δ
    b2 = 2.0 - (1.0 + δ)/δ
    x2 = b2/u22
    e2 = x2-1

    b1 = 1 + δ
    x1 = (b1-x2)/δ
    e1 = x1 - 1
    return e1, e2
end

function tbtp(δ)
    u22 = 1.0 - δ
    b2 =  (1.0 + δ) - 2.0*δ
    x2 = b2/u22
    e2 = x2-1

    b1 = 2
    x1 = (b1-x2)
    e1 = x1 - 1
    return e1, e2
end 

δ = eps(1.0)/4

e1,e2 = tbt(δ)
println((e1,e2))
e1,e2 = tbtp(δ)
println((e1,e2))

# Test LU factorization
#A = [1.0 2 3; 4 5 6; 7 8 9]
#A = rand(1000,1000)
#B = deepcopy(A)
#@time L, U, p = lu!(A)
#L*U - B[p, :]

# Test Cholesky factorization
A = rand(20,20)
C = A'*A
D = deepcopy(C)
@time L = chol(C)
#@benchmark L = chol3!(D)

#@benchmark L2 = cholesky(C)

# test gaussian elimination with partial pivot
n = 10
A = rand(n,n)
x = rand(n)
b = A*x
@time xt = gepp!(A,b)
err = norm(xt-x)
println(err)

A = [2.0 -1.0 0; -1.0 2.0 -1.0; 0 -1.0 2.0]
x = rand(3)
b = A*x
x0 = rand(3)
@time x1, it = gaussseidel(A, b, x0)
err = norm(x1-x)
println(err)
println(x1)
println(it)
