using Plots
"""
    newton(f, df)
    newton(f, df, x0)
    newton(f, df, x0, tol)

Find roots of the noninear function `f` using Netwon's method.

# Argument
- `f::Function`: the nonlinear function.
- `df::function`: the derivative of the nonlinear function.
- `x0::Float64`: initial guess.
- 'tol::Float64': error tolerance.

# Example
```julia-repl
julia> newton(x->cos(x)-x, x->-sin(x)-1)
```
"""
function newton(f::Function, df::Function, x0::Float64=1.0, tol::Float64=1e-7)
    err = 1.0
    it = 0
    xp = x0
    while err > tol
        xc = x0 - f(xp)/df(xp)
        err = abs(xc-xp)
        xp = xc
        it += 1
    end
    return xp, it
end

"""
    secant(f)
    secant(f, x0, x1)
    secant(f, x0, x1, tol)

Find roots of the noninear function `f` using secant method.

# Argument
- `f::Function`: the nonlinear function.
- `x0::Float64`: the first initial guess.
- `x1::Float64`: the second initial guess.
- `tol::Float64`: error tolerance.

# Example
```julia-repl
julia> secant(x->cos(x)-x)
```
"""
function secant(f::Function, x0=1, x1 = 2, tol=1e-14)
    err = 1.0
    it = 0
    xp1 = x1
    xp2 = x0
    while err > tol
        xc = xp1 - f(xp1)*(xp1-xp2)/(f(xp1)-f(xp2))
        err = abs(xp1-xc)
        xp2 = xp1
        xp1 = xc
        it += 1
    end
    return xp1, it
end

"""
    bisect(f, a, b)
    bisect(f, a, b, tol)
    bisect(f, a, b, tol, maxit)

Find roots of the noninear function `f` using bisection.

# Argument
- `f::Function`: the nonlinear function.
- `a::Float64`: the lower bound of the interval.
- `b::Float64`: the upper bound of the interval.
- `tol::Float64`: error tolerance.
- `maxit::Int64`: maximum number of iteration.

# Example
```julia-repl
julia> bisection(x->cos(x)-x, 0, pi)
```
"""
function bisect(f::Function, a::Number, b::Number, tol=1e-7, maxit=100)
    if b < a
        error("the input of interval is not correct")
    end
    if f(a)*f(b) > 0
        error("You must give an input with difference sign")
    end
    it = 0
    while (b-a)>tol && it < maxit
        c = (a+b)/2
        if f(c) == 0 
            return c
        elseif f(a)*f(c) < 0
            b = c
        else
            a = c
        end
        it += 1
    end
    return (a+b)/2, it
end

"""
    fixedpoint(g, x0)
    fixedpoint(g, x0, tol)
    fixedpoint(g, x0, tol, maxit)

Find roots of the noninear function `x=g(x)` using fixed point iteration.

# Argument
- `g::Function`: the fixed point function.
- `x0::Float64`: the initial guess.
- `tol::Float64`: error tolerance.
- `maxit::Int64`: maximum number of iteration.

# Example
```julia-repl
julia> fixedpoint(x->cos(x)-x, 0, pi)
```
"""
function fixedpoint(g::Function, x0, tol=1e-15, maxIt=50)
    it = 0
    x1 = x0 + 1
    while abs(x1-x0)>tol && it < maxIt
        x1 = x0
        x0 = g(x0)
        it += 1
    end
    return x0, it
end

"""
    cobweb(g, a, b, x0, N)

Generate the cobweb plot associated with the orbits x_n+1=g(x_n).

# Argument
- `g::Function`: the fixed point function.
- `a::Float64`: the lower bound of the interval.
- `b::Float64`: the upper bound of the interval.
- `x0::Float64`: the initial guess.
- `N::Int64`: the number of iteration.

# Example
```julia-repl
julia> cobweb(x->cos(x), 0, pi, 1, 30)
```
"""
function cobweb(g::Function,a,b,x0,N)
    #generate N linearly space values on (a,b)
    x = collect(range(a, b, length=N+1))
    y = g.(x);
    plot(x,y,linecolor=:black, legend = false)
    plot!(x,x,linecolor=:black, legend = false)
    x[1] = x0
    #@gif for i in 1:N
    anim = @animate  for i in 1:N
        x[i+1] = g(x[i])
        plot!([x[i]; x[i]], [x[i], x[i+1]], linecolor=:red,legend = false)
        plot!([x[i]; x[i+1]], [x[i+1], x[i+1]], linecolor=:red,legend = false)
    end
    return anim
end

"""
    viznewton(f, df, a, b, x0, N)

Visualize the Newton's method for the nonlinear equation f(x)=0.

# Argument
- `f::Function`: the nonlinear function.
- `df::function`: the derivative of the nonlinear function.
- `a::Float64`: the lower bound of the interval.
- `b::Float64`: the upper bound of the interval.
- `x0::Float64`: the initial guess.
- `N::Int64`: the number of iteration.

# Example
```julia-repl
julia> cobweb(x->cos(x), 0, pi, 1, 30)
```
"""
function viznewton(f::Function, df::Function, a,b,x0,N)
    #generate N linearly space values on (a,b)
    x = collect(range(a, b, length=N+1))
    y = f.(x);
    plot(x,y,linecolor=:black, legend = false)
    plot!(x,zeros(N+1),linecolor=:black, legend = false)
    x[1] = x0
    #@gif for i in 1:N
    anim = @animate  for i in 1:N
        x[i+1] = x[i] - f(x[i])/df(x[i])
        plot!([x[i]; x[i]], [0, f(x[i])], linecolor=:red,legend = false)
        plot!([x[i]; x[i+1]], [f(x[i]), 0], linecolor=:red,legend = false)
    end
    return anim
end


"""
    brent(f, a, b, tol, maxit)

Find roots of the noninear function `f` using Brent algorithm

# Argument
- `f::Function`: the nonlinear function.
- `a::Float64`: the lower bound of the interval.
- `b::Float64`: the upper bound of the interval.
- `tol::Float64`: error tolerance.
- `maxit::Int64`: maximum number of iteration.

# Example
```julia-repl
julia> brent(x->cos(x)-x, 0, pi)
```
"""
function brent(f::Function, a::Float64, b::Float64, tol::Float64=1e-13)
    if f(a)*f(b) >= 0.0
        error("Error: the root is not bracket")
    end
    if abs(f(a)) < abs(f(b))
        a, b = b, a
    end
    c = a
    d = c
    mflag = 1
    while abs(f(b)) > tol || abs(b-a) > tol
        if ~isapprox(f(a), f(c)) && ~isapprox(f(b), f(c))
            # inverse quadratic interpolation
            s = a*f(b)*f(c)/(f(a)-f(b))/(f(a)-f(c)) -
                b*f(a)*f(c)/(f(b)-f(a))/(f(b)-f(c)) -
                c*f(a)*f(b)/(f(c)-f(a))/(f(c)-f(b))
        else
            # secan method
            s = b - f(b)*(b-a)/(f(b)-f(a))
        end
        if (s > max((3a+b)/4, b) || s < min((3a+b)/4, b)) ||
            ( mflag == 1 && abs(s-b) >= abs(b-c)/2.0) ||
            ( mflag == 0 && abs(s-b) >= abs(c-d)/2.0) ||
            ( mflag == 1 && abs(b-c) < tol) ||
            ( mflag == 0 && abs(c-d) < tol) 
            s = (a+b)/2
            mflag = 1
        else
            mflag = 0
        end
        d = c
        c = b
        if f(a)*f(s) < 0 
            b = s
        else 
            a = s
        end
        if abs(f(a)) < abs(f(b))
            a, b = b, a
        end
    end
    return b
end