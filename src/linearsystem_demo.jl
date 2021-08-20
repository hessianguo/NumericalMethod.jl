function tbt(δ)
    u22 = 1.0 - 1.0/δ
    b2 = 2.0 - (1.0 + δ)/δ
    x2 = b2/u22
    e2 = x2-1

    b1 = 1 + δ
    x1 = (b1-x2)/δ
    e1 = x1 - 1
    return e1, e2
end

function tbtp(δ)
    u22 = 1.0 - δ
    b2 =  (1.0 + δ) - 2.0*δ
    x2 = b2/u22
    e2 = x2-1

    b1 = 2
    x1 = (b1-x2)
    e1 = x1 - 1
    return e1, e2
end 

δ = eps(1.0)/4

e1,e2 = tbt(δ)
println((e1,e2))
e1,e2 = tbtp(δ)
println((e1,e2))