function val = ctr(f::Function, a=0, b=1, N = 10)
    h = (b-a)/N
    val = 0
    val += f(a)/2
    for j = 1:N-1
        x = a + j*h
        val += f(x)
    end
    val += f(b)/2
    val *= h
    return val
end