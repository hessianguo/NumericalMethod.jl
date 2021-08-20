include("datafitting.jl")
function f(x)
    t = collect(0:3)
    y = [2.0; 0.7; 0.3; 0.1]
    r = y - x[1].*exp.(x[2].*t)
    f =  sum(r.^2)/2
    jac = [-exp.(x[2].*t) -x[1].*t.*exp.(x[2].*t)]
    g = jac'*r
    return f, jac, g, r
end


# good initial guess
x0 = [1;0]
x = gaussnewton(x0, f)
println(x)

# bad initial guess
x0 = [-3;3]
x = gaussnewton(x0, f)
println(x)

# Levenberg-Marquardt with good initial guess
x0 = [1;0]
x = levenbergmarquardt(x0, f)
println(x)


# Levenberg-Marquardt with bad initial guess
x0 = [-3;3]
x = levenbergmarquardt(x0, f)
println(x)