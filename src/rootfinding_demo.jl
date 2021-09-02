include("rootfinding.jl")

f(x) = sin(x)
df(x) = cos(x)

x, it = bisect(f, 0.1, 4.0)

x, it = newton(f, df, 4.0)

g(x) = cos(x)
#anim = cobweb(g, 0, 1, 0.5, 50)
#gif(anim, "anim_fps15.gif", fps = 1)

g1(x) = x - x^3 - 4*x^2 + 10
g2(x) = sqrt(complex(10/x - 4*x))
g3(x) = sqrt(10 - x^3)/2
g4(x) = sqrt(10/(4+x))
g5(x) = x - (x^3 + 4*x^2 - 10)/(3*x^2 + 8*x)
#=
x1, it1 = fixedpoint(g1, 1.5)
x2, it2 = fixedpoint(g2, 1.5)
x3, it3 = fixedpoint(g3, 1.5)
x4, it4 = fixedpoint(g4, 1.5)
x5, it5 = fixedpoint(g5, 1.5)
println((x1,it1))
println((x2,it2))
println((x3,it3))
println((x4,it4))
println((x5,it5))

f(x) = cos(x)-x
df(x) = -sin(x) - 1
#anim = viznewton(f, df, -3, 10, 6, 100)
#gif(anim, "newton_fps1.gif", fps = 1)

x, it = secant(f, 6, 3)
=#

x = brent(x->cos(x)-x, 0.0, 4.0)
println(x)
x1 = bisect(x->cos(x)-x, 0.0, 4.0)
println(x1)