function newton(f::Function, df::Function, x0=1, tol=1e-7)
    err = 1.0
    it = 0
    while err > tol
        x1 = x0 - f(x0)/df(x0)
        err = abs(x1-x0)
        x0 = x1
        it += 1
    end
    return x0, it
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
    plot!(x,x,linecolor=:red, legend = false)
    x[1] = x0
    @gif for i in 1:N
        x[i+1] = g(x[i])
        plot!([x[i]; x[i]], [x[i], x[i+1]], legend = false)
        plot!([x[i]; x[i+1]], [x[i+1], x[i+1]], legend = false)
    end
end