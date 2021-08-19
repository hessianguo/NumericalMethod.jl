function ctr(f::Function, box=[0;1], N = 10)
    h = (box[2]-box[1])/N
    val = 0
    val += f(box[1])/2
    for j = 1:N-1
        x = box[1] + j*h
        val += f(x)
    end
    val += f(box[2])/2
    val *= h
    return val
end