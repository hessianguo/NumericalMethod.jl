function lu!(A,b)
    m,n = size(A)
    x = zeros(size(b))
    if m != n
        error("the matrix A is not a square matrix")
    end
    for i in 1:n
        # find the pivot
        val, idx = findmax(A[:,i])
        if abs(A[i,idx]) < eps(1.0)
            error("the matrix is singular")
        else
            # swap row
            A[idx,:], A[i,:] = A[i,:], A[idx,:]
            b[i], b[idx] = b[idx], b[i]
            for k in i+1:n
                den = A[i,k]/A[i,i]
                for j in i+1:n
                    A[k,j] = A[k,j] - A[i,j]*den
                end
                b[k] = b[k] - b[i]*den
            end
        end
    end
end