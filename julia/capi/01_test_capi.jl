
# ssh -X msycmp545
# source ~/tools/setEnvG2.csh
# /u/gviguier/Softs/julia/bin/julia 01_test_capi.jl

#if (length(ARGS) > 0)
#println("argumens : ")
#for x in ARGS
#   println(x)
#end
#end

include("capi.jl")

#dataset = "a:::1006400:gviguier/wavelet"
dataset = "a:::1006400:/oleblanc/kosmos/mig/2sl_trg_pafwi_hc45_g1212"
attributes = "shotindex32,recindex32,shotx,shoty,shotdepth,recx,recy,recdepth"
selection = "where shotindex32=300"

request = "select $attributes from $dataset $selection"
id = Capi.open(request)
n = Capi.getNInstances(id)
println("Number of instances : $n")
Capi.close(id)

println("OK")
