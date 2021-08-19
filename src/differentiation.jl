function ffd(f::Function, x=0.0, h=1e-8)
    val = (f(x+h)-f(x))/h
    return val
end

function bfd(f::Function, x=0.0, h=1e-8)
    val = (f(x)-f(x-h))/h
    return val
end

function cfd(f::Function, x=0.0, h=1e-5)
    val = (f(x+h)-f(x-h))/2/h
    return val
end