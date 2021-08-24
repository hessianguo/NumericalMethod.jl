using LinearAlgebra
function lu!(A)
    n,n = size(A)
    p = collect(1:n)
    for k in 1:n-1
        r,m = findmax(abs.(A[k:n,k]))
        m = m + k - 1
        if A[m,k] != 0
            if m != k
                p[k], p[m] = p[m], p[k]
                for j in 1:n
                    A[k,j], A[m,j] = A[m,j], A[k,j]
                end
            end
            for i in k+1:n
                A[i,k] /= A[k,k]
                for j in k+1:n
                    A[i,j] -= A[i,k]*A[k,j]
                end
            end
        end
    end
    L = tril(A,-1) + Matrix{Float64}(I, n, n)
    U = triu(A)
    return L, U, p
end

function chol(A)
    n,n = size(A)
    L = zeros(n,n)
    @inbounds begin
         for i in 1:n
             tmp = 0
             for k in 1:i-1
                tmp += L[i,k].^2
            end
            L[i,i] = sqrt(A[i,i] - tmp)
            for j in i+1:n
                L[j,i] = A[i,j] / L[i,i]
                for k in 1:i-1
                    L[j,i] -=  L[i,k].*L[j,k] / L[i,i]
                end
            end
        end 
    end
    return L
end

function chol2!(A)
    n,n = size(A)
    for i in 1:n
        A[i,i] = sqrt(A[i,i] - sum(A[i,1:i-1].^2))
        for j in i+1:n
            A[j,i] = (A[i,j] - sum(A[i,1:i-1].*A[j,1:i-1])) / A[i,i]
        end
    end
    return tril(A)
end

function chol3!(A)
    n,n = size(A)
    for i in 1:n
        tmp = 0
        for k in 1:i-1
            tmp += A[i,k].^2
        end
        A[i,i] = sqrt(A[i,i] - tmp)
        for j in i+1:n
            A[j,i] = A[i,j] / A[i,i]
            for k in 1:i-1
                A[j,i] -=  A[i,k].*A[j,k] / A[i,i]
            end
        end
    end
    return tril(A)
end

function ge!(A, b)
    n,n = size(A)
    p = collect(1:n)
    for k in 1:n-1
        r,m = findmax(abs.(A[k:n,k]))
        m = m + k - 1
        if A[m,k] != 0
            if m != k
                p[k], p[m] = p[m], p[k]
                for j in 1:n
                    A[k,j], A[m,j] = A[m,j], A[k,j]
                end
            end
            for i in k+1:n
                A[i,k] /= A[k,k]
                for j in k+1:n
                    A[i,j] -= A[i,k]*A[k,j]
                end
            end
        end
    end
    L = tril(A,-1) + Matrix{Float64}(I, n, n)
    U = triu(A)
    return L, U, p
end