function deMere(numReps::Int)
    numRolls = 4
    numSixes = 0
    for run in 1:numReps
        roll = rand(1:6, numRolls, 1)
        if any( roll .== 6)
            numSixes += 1
        end
    end
    probSix = numSixes/numReps
end
