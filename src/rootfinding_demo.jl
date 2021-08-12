include("rootfinding.jl")

f(x) = sin(x)
df(x) = cos(x)

x, it = bisect(f, 0.1, 4)

x, it = newton(f, df, 4)