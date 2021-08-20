using LinearAlgebra
eye(n) = Matrix{Float64}(I, n, n)

function gaussnewton(x0, f, tol=1e-6, maxit = 100)
    alpha = 1.0e-4
    it = 1
    xc = x0
    fc, jac, gc = f(xc)
    n_f = 1
    n_g = 1
    n_h = 0
    while norm(gc) > tol && it < maxit
        dc = (jac'*jac)\gc
        lambda = 1.0
        xt = xc - lambda*dc
        ft, = f(xt)
        n_f = n_f
        iarm = 0
        it += 1
        # goal for sufficient decrease
        fgoal = fc - alpha*lambda*(gc'*dc)
        while ft > fgoal
            iarm += 1
            lambda = lambda/2
            fgoal = fc - alpha*lambda*(gc'*dc)
            xt = xc - lambda*dc
            ft, = f(xt)
            n_f += 1
            if iarm > 10
                println("Armijo error in Gauss-Newton")
            end
        end
        xc = xt
        fc, jac, gc = f(xc)
        n_f += 1
        n_g += 1
    end
    return xc
end

function levenbergmarquardt(x0, f, tol=1e-6, maxit=100)
    it = 1
    xc = x0
    fc, jac, gc, rc = f(xc)
    nu0 = 0.001
    m = length(gc)
    n = length(xc)
    nu = norm(gc)
    while norm(gc) > tol && it < maxit
        it += 1
        hc = [jac; sqrt(nu).*eye(n)]
        rhs = [rc; zeros(n)]
        dc = -hc\rhs
        xt = xc + dc
        xp, nup, id = trustregiontest(f, xc, xt, fc, jac, gc, nu, nu0, rc)
        if id > 30
            error("To many iteraion in trust region solver")
        end
        xc = xp
        nu = nup 
        fc, jac, gc, rc = f(xc)
    end
    return xc
end

function trustregiontest(f, xc, xt, fc, jac, gc, nu, nu0, rc)
    mu0 = 0.0
    mulow = 0.25
    muhigh = 0.75
    mup = 2.0
    mdown = 0.5
    z = xc
    n = length(z)
    it = 0
    while z == xc && it < 30
        ft,  = f(xt)
        it += 1
        s = xt - xc
        diff = fc - ft
        pred = - (gc'*s)/2.0
        rat = diff/pred
        if rat < mu0
            nu = max(nu*mup, nu0)
            hc = [jac; sqrt(nu).*eye(n)]
            rhs = [rc; zeros(n)]
            dc = -hc\rhs
            xt = xc + dx
        elseif rat < mulow
            z = xt
            nu = max(nu*mup, nu0)
        else
            z = xt
            if rat > muhigh
                nu = mdown * nu
                if nu < nu0 
                    nu = 0.0
                end
            end
        end
    end
    return z, nu, it
end