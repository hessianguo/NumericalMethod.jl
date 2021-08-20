using Plots
function newton(f::Function, df::Function, x0=1, tol=1e-7)
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

function secant(f::Function, x0=1, x1 = 1, tol=1e-14)
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

function bisect(f::Function, a::Number, b::Number, tol=1e-7, maxIt=100)
    if b < a
        error("the input of interval is not correct")
    end
    if f(a)*f(b) > 0
        error("You must give an input with difference sign")
    end
    it = 0
    while (b-a)>tol && it < maxIt
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

function cobweb(g::Function,a,b,x0,N)
    # generate the cobweb plot associated with
    # the orbits x_n+1=g(x_n).
    # N is the number of iterates, and
    # (a,b) is the interval
    # x0 is the initial point.
    # use @f to pass function ...
    
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

function viznewton(f::Function, df::Function, a,b,x0,N)
    # visualize Newton's method
    # the orbits x_n+1=g(x_n).
    # N is the number of iterates, and
    # (a,b) is the interval
    # x0 is the initial point.
    # use @f to pass function ...
    
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