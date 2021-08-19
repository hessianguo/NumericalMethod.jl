using Statistics
function demere(num::Int)
    numrolls = 4
    numsixes = 0
    for run in 1:num
        roll = rand(1:6, numrolls, 1)
        if any( roll .== 6)
            numsixes += 1
        end
    end
    probsix = numsixes/num
    return probsix
end

function roulette(k, t, num::Int)
    p = 18/37
    numruin = 0
    numbet = 0
    for run in 1:num
        money = k
        while money > 0 && money < t
            if rand(1)[1] < p
                money += 1
            else
                money -= 1
            end
            numbet += 1
        end
        if money == 0 
            numruin += 1
        end
    end
    probruin = numruin / num
    averagebet = numbet / num
    return probruin, averagebet
end

function hitmiss(f::Function, box = [0; 1], num=10000; fmin=0, fmax=1) 
   x = (box[2]-box[1]).*rand(num,1) .+ box[1]
   y = (fmax-fmin).*rand(num,1) .+ fmin
   rectarea = (fmax-fmin)*(box[2]-box[1])
   prop = sum(y.<f.(x))/num
   return prop*rectarea
end

function crudemc(f::Function, box = [0;1], num=10000)
   x = (box[2]-box[1]).*rand(num,1) .+ box[1]
   fmean = mean(f.(x))
   return (box[2]-box[1])*fmean
end