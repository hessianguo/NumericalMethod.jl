using LinearAlgebra
"""
    lu!(A)
Compute LU factorization of the matrix `A`.

# Example
```julia-repl
julia> lu!([1 2; 3 4])
```
"""
function lu!(A::AbstractMatrix)
    n,n = size(A)
    p = collect(1:n)
    for k in 1:n-1
        m = argmax(abs.(A[k:n,k]))
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

"""
    chol!(A)
Compute cholesky factorization of the spd matrix `A`.

# Argument
- `A:AbstractMatrix`: symmetric positive definite matrix

# Example
```julia-repl
julia> chol([1 2; 2 5])
```
"""
function chol(A::AbstractMatrix)
    n,n = size(A)
    L = similar(A)
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

"""
    gepp!(A,b)
Solve the linear system ``Ax=b`` using Gaussian elimination with partial pivot

# Example
```julia-repl
julia> A = rand(3,3)
julia> b = rand(3)
julia> x = gepp!(A, b)
```
"""
function gepp!(A::AbstractMatrix, b::AbstractVector)
    n,n = size(A)
    for k in 1:n-1
        # pivot
        m = argmax(abs.(A[k:n,k]))
        m = m + k - 1
        if A[m,k] != 0
            if m != k
                b[k], b[m] = b[m], b[k]
                for j in 1:n
                    A[k,j], A[m,j] = A[m,j], A[k,j]
                end
            end
            for i in k+1:n
                A[i,k] /= A[k,k]
                b[i] -= A[i,k]*b[k]
                for j in k+1:n
                    A[i,j] -= A[i,k]*A[k,j]
                end
            end
        end
    end
    # back substituion
    x = zeros(n)
    for k in n:-1:1
        for j = n:-1:k+1
            b[k] -= A[k,j]*x[j]
        end
        x[k] = b[k] / A[k,k]
    end
    return x
end

"""
    jacobi(A, b, x0)
    jacobi(A, b, x0, tol)

Solve the linear system using Jacobi method.

# Example
```julia-repl
julia> A = rand(3,3)
julia> b = rand(3)
julia> x0 = rand(3)
julia> x = jacobi(A, b, x0)
```
"""
function jacobi(A::AbstractMatrix, b::AbstractVector, x::AbstractVector, tol::Float64=1e-10)
    xc = similar(b)
    n, = size(b)
    err = 1.0
    it = 0
    while err > tol
        @inbounds for i in 1:n
            xc[i] = b[i]
            @inbounds for k in 1:n
                if k != i
                    xc[i] -= A[i,k]*x[k]
                end
            end
            xc[i] /= A[i,i]
        end
        err = norm(x-xc)
        x = copy(xc)
        it += 1
    end
    return xc, it
end

"""
    gaussseidel(A, b, x0)
    gaussseidel(A, b, x0, tol)

Solve the linear system using Gauss-Seidel method.

# Example
```julia-repl
julia> A = rand(3,3)
julia> b = rand(3)
julia> x0 = rand(3)
julia> x = gaussseidel(A, b, x0)
```
"""
function gaussseidel(A::AbstractMatrix, b::AbstractVector, x::AbstractVector, tol::Float64=1e-10)
    n, = size(b)
    err = 1.0
    it = 0
    xc = copy(x)
    while err > tol
        @inbounds for i in 1:n
            xc[i] = b[i]
            @inbounds for k in 1:n
                if k != i
                    xc[i] -= A[i,k]*xc[k]
                end
            end
            xc[i] /= A[i,i]
        end
        err = norm(x-xc)
        x = copy(xc)
        it += 1
    end
    return xc, it
end
