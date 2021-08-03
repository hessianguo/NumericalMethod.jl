function newton(f::Function, df::Function, x0=1, tol=1e-7)
    err = 1.0
    while err > tol
        x1 = x0 - f(x0)/df(x0)
        err = abs(x1-x0)
        x0 = x1
    end
    return x0
end
