function fib(n::Int=0)
fn1 = 1
fn2 = 0
if (n==0)||(n==1)
    fn = n
else 
    for count in 2:n
        fn = fn2 + fn1
        fn2 = fn1
        fn1 = fn
    end
end
return fn
end