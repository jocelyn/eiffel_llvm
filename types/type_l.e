note
	description: "Summary description for {TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_L

create

	make_from_pointer,
	make_void

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	make_void (ctx: LLVM_CONTEXT)
		do
			item := make_void_external (ctx.item)
		end

feature

		item: POINTER

feature {NONE} -- Externals

	make_void_external (ctx: POINTER): POINTER
		external
			"C++ inline use %"llvm/Type.h%""
		alias
			"[
				return (EIF_POINTER)llvm::Type::getVoidTy (*((llvm::LLVMContext *)$ctx));	
			]"
		end
end
