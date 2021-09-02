using Plots

t = range(0, 4π, length = 100)
r = range(1, 0, length = 100)

x = cos.(t) .* r
y = sin.(t) .* r

@gif for i in eachindex(x)
    scatter((x[i], y[i]), lims = (-1, 1), label = "")
end

@gif for i in eachindex(x)
    plot(x[1:i], y[1:i], lims = (-1, 1), label = "")
    scatter!((x[i], y[i]), color = 1, label = "")
end

@gif for i in eachindex(x)
    plot(x[1:i], y[1:i], alpha = max.((1:i) .+ 10 .- i, 0) / 10, lims = (-1, 1), label = "")
    scatter!((x[i], y[i]), color = 1, label = "")
end