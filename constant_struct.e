note
	description: "Summary description for {CONSTANT_STRUCT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANT_STRUCT

inherit
	CONSTANT

create

	make,
	make_packed

feature {NONE}

	make (ctx: LLVM_CONTEXT; v: CONSTANT_STLVECTOR)
		do
			item := make_packed_external (ctx.item, v.item, False)
		end

	make_packed (ctx: LLVM_CONTEXT; v: CONSTANT_STLVECTOR; packed: BOOLEAN)
		do
			item := make_packed_external (ctx.item, v.item, packed)
		end

feature {NONE} -- Externals

	make_packed_external (ctx: POINTER; v: POINTER; packed: BOOLEAN): POINTER
		external
			"C++ inline use %"llvm/Constants.h%""
		alias
			"[
				return llvm::ConstantStruct::get (*((llvm::LLVMContext *)$ctx), *((const std::vector <llvm::Constant *> *)$v), $packed);
			]"
		end
end
