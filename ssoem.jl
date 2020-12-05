struct Slave
	name::String
	obits::UInt16
	obytes::UInt32
	outputs_ptr::Ptr{UInt8}
	raw_outputs::Array{UInt8}
	ostartbit::UInt8
	ibits::UInt16
	ibytes::UInt32
	inputs_ptr::Ptr{UInt8}
	raw_inputs::Array{UInt8}
	istartbit::UInt8
end


struct Ssoem
	slaves::Vector{Slave}
	function Ssoem(iface::String)
		# Initialize the C backend, and start Ecat bus
		@ccall "libssoem.so".ssoem_init(iface::Cstring)::Cvoid
		# Get basic bus info from the C backend
		slave_count = @ccall "libssoem.so".ssoem_get_slave_count()::Cint

		slaves = Slave[]
		for idx in 1:slave_count
			name = unsafe_string(@ccall "libssoem.so".ssoem_get_slave_name_ptr(idx::Cint)::Cstring)
			obits = @ccall "libssoem.so".ssoem_get_slave_obits(idx::Cint)::Cushort
			obytes = @ccall "libssoem.so".ssoem_get_slave_obytes(idx::Cint)::Cushort
			outputs_ptr = @ccall "libssoem.so".ssoem_get_outputs_ptr(idx::Cint)::Ptr{Cuchar}
			ostartbit = @ccall "libssoem.so".ssoem_get_ostartbit(idx::Cint)::Cchar
			ibits = @ccall "libssoem.so".ssoem_get_slave_ibits(idx::Cint)::Cushort
			ibytes = @ccall "libssoem.so".ssoem_get_slave_ibytes(idx::Cint)::Cushort
			inputs_ptr = @ccall "libssoem.so".ssoem_get_inputs_ptr(idx::Cint)::Ptr{Cuchar}
			istartbit = @ccall "libssoem.so".ssoem_get_istartbit(idx::Cint)::Cchar

			if obits > 0 && obytes == 0
				raw_outputs_size = 1
			else
				raw_outputs_size = obytes
			end
			raw_outputs = unsafe_wrap(Array{UInt8}, outputs_ptr, raw_outputs_size)

			if ibits > 0 && ibytes == 0
				raw_inputs_size = 1
			else
				raw_inputs_size = ibytes
			end
			raw_inputs = unsafe_wrap(Array{UInt8}, inputs_ptr, raw_inputs_size)

			slave = Slave(
				name,
				obits,
				obytes,
				outputs_ptr,
				raw_outputs,
				ostartbit,
				ibits,
				ibytes,
				inputs_ptr,
				raw_inputs,
				istartbit,
				)

			push!(slaves, slave)
		end
		return new(slaves)
	end
end


function write(slave::Slave, idx::Int, value)
	slave.raw_outputs[idx:(idx+sizeof(value)-1)] = reinterpret(UInt8, [value])
end

function read(slave::Slave, idx::Int, type::DataType)
	return reinterpret(type, slave.raw_inputs[idx:(idx+sizeof(type)-1)])[1]
end
