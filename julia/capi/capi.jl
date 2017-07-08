
module Capi

#export parseRetValue, check, open, close, getNInstances

typealias capi_id Ptr{Void}

function parseRetValue(status::Int32)
	"TODO $(@__FILE__):$(@__LINE__)"
end

function check(s::Int32)
	if (s != 0)
		error("$(parseRetValue(s))")
	end
end

function open(request::String)
	println(request)
	id = Ref{capi_id}()
	ret = ccall( (:cCapi_init, :libG2), Int32, ( Ptr{Ptr{Void}}, Ptr{UInt8}, ), id, request)
	check(ret)
	id[]
end

function close(id::capi_id)
	ret = ccall( (:cCapi_close, :libG2), Int32, ( Ptr{Ptr{Void}}, ), id)
	check(ret)
end

function getNInstances(id::capi_id)
	n = Ref{Int64}()
	ret = ccall( (:cCapi_getNInstances, :libG2), Int32, ( Ptr{Void}, Ptr{Int64}), id, n )
	check(ret)
	n[]
end

#extern Int32                            cCapi_getAttributeByName( CapiID id, const char* name, Int32* dataType, Int32* length, Int32* sampleRate, Int32* keyNumber );
#

# #Int32   cCapi_read( CapiID id, void* dest, Int32 ordinal, Int64 first, Int64 last );
# function read(id::capi_id,)
# 	ret = ccall( (:cCapi_read, :libG2), Int32, ( Ptr{Void}, Ptr{Int64}), id, n )
# 	check(ret)
# end

end
