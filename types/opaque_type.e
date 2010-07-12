note
	description: "Summary description for {OPAQUE_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPAQUE_TYPE

inherit
	DERIVED_TYPE

create

	make

feature {NONE}

	make (ctx: LLVM_CONTEXT)
		do
			item := make_external (ctx.item)
		end

feature {NONE} -- Externals

	make_external (ctx: POINTER): POINTER
		external
			"C++ inline use %"llvm/DerivedTypes.h%""
		alias
			"[
				return llvm::OpaqueType::get (*((llvm::LLVMContext *)$ctx));		
			]"
		end
end
