function demere(num_reps::Int)
    num_rolls = 4
    num_sixes = 0
    for run in 1:num_reps
        roll = rand(1:6, num_rolls, 1)
        if any( roll .== 6)
            num_sixes += 1
        end
    end
    prob_six = num_sixes/num_reps
    return prob_six
end

function roulette(k, t, num_reps)
    p = 18/37
    num_ruin = 0
    num_bet = 0
    for run in 1:num_reps
        money = k
        while money > 0 && money < t
            if rand(1)[1] < p
                money += 1
            else
                money -= 1
            end
            num_bet += 1
        end
        if money == 0 
            num_ruin += 1
        end
    end
    prob_ruin = num_ruin / num_reps
    average_bet = num_bet / num_reps
    return prob_ruin, average_bet
end
