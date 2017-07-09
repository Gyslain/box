using Plots
pyplot()

default(show = true)

lanczos(a, x) = abs(x) < abs(a) ? sinc(x) * sinc(x/a) : zero(x)

# todo utiliser des tuples a place des []
getLanczosKernel(len::Integer) = [ lanczos(len, x) for x = -len+0.5 : 0.5 : len-0.5 ]
getLanczosKernel2(len::Integer) = [ lanczos(len, x) for x = -len+0.5 : len-0.5 ] # 1 and 0 removed
getSimplifiedLanczosKernel(len::Integer) = [ lanczos(len, x) for x = 0.5 : len - 0.5 ]   # symetrics and 1 and 0 removed


a = 2
min_d = -3.
max_d = 5.
N = 9

x1 = linspace(min_d, max_d, N)
x2 = linspace(min_d, max_d,2*N-1)

square = [ v*v for v in x1 ]
plot(x1, square, label="square", marker=:o)

ii = [5,6,7,8]
#for i = 1:length(square)
for i = ii
   lanczosArray = [ square[i] * lanczos(a, x - x1[i] ) for x in  x2 ]
   plot!(x2,lanczosArray, label="lanczos (a=$a, i=$i)", marker=:o)
end



plot(getLanczosKernel(a), label="kernel", marker=:o, reuse=false)
#plot(getSimplifiedLanczosKernel(a), label="kernel", marker=:o, reuse=false)




kernel = getLanczosKernel2(a)
plot(kernel, label="kernel2", marker=:o, reuse=false)

assert(length(kernel)%2 == 0)
tmp = zeros(length(square))
for i in eachindex(square)
   println("\ni=$i")
   for j in eachindex(kernel)
     id = i - Int64(length(kernel)/2) + j-1
     if (id >= 1 && id <= length(square))
         tmp[id] += square[i] * kernel[j]
      println("id=$id, $(square[i])*$(kernel[j])")
     end
   end
end

#plot(tmp,reuse=false, marker=:o)


upsampled = Array{Float64,1}(length(x2))

for i=1:length(square)-1
   upsampled[2*i-1] = square[i]
   upsampled[2*i] =  tmp[i]
end
upsampled[end] = square[end]
plot(upsampled, label="upsampled square", marker=:o, reuse=false)

println("OK")
