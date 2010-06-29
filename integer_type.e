note
	description: "Summary description for {INTEGER_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_TYPE

inherit
	TYPE

create
	get_int32_type

feature {NONE}

	get_int32_type (c: LLVM_CONTEXT)
		do
			item := get_int32_type_external (c.item)
		end

feature {NONE} -- Externals

	get_int32_type_external (c: POINTER): POINTER
		external
			"C++ inline use %"llvm/Type.h%""
		alias
			"[
				return (EIF_POINTER)llvm::Type::getInt32Ty (*((llvm::LLVMContext *)$c));
			]"
		end
end
