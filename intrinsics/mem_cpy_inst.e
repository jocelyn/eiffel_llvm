note
	description: "Summary description for {MEM_CPY_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MEM_CPY_INST

inherit
	MEM_TRANSFER_INST
		rename
			make as make_call
		end

create

	make

feature {NONE}

	make (ctx: LLVM_CONTEXT; m: MODULE)
		local
			overload_array: SPECIAL [POINTER]
			array_pointer: POINTER
		do
			create overload_array.make_empty (3)
			overload_array.extend ((create {POINTER_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 8))).item)
			overload_array.extend ((create {POINTER_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 8))).item)
			overload_array.extend ((create {INTEGER_TYPE}.make (ctx, 32)).item)
			array_pointer := overload_array.base_address
			item := make_external (m.item, memcpy_id, $array_pointer, 3)
		end

feature {NONE} -- Externals

	memcpy_id: NATURAL_32
		external
			"C++ inline use %"llvm/IntrinsicInst.h%""
		alias
			"[
				return llvm::Intrinsic::ID.memcpy
			]"
		end
end
