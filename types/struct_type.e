note
	description: "Summary description for {STRUCT_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRUCT_TYPE

inherit
	COMPOSITE_TYPE

create

	make,
	make_from_pointer,
	make_packed

feature {NONE}

	make (ctx: LLVM_CONTEXT; params: TYPE_VECTOR)
		do
			item := make_external (ctx.item, params.item)
		end

	make_packed (ctx: LLVM_CONTEXT; params: TYPE_VECTOR; is_packed: BOOLEAN)
		do
			item := make_packed_external (ctx.item, params.item, is_packed)
		end

feature

	get_type_at_index (idx: NATURAL_32): TYPE_L
		do
			create Result.make_from_pointer (get_type_at_index_external (item, idx))
		end

	index_valid (idx: NATURAL_32): BOOLEAN
		do
			Result := index_valid_external (item, idx)
		end

feature {NONE} -- Externals

	get_type_at_index_external (item_a: POINTER; idx: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/DerivedTypes.h%""
		alias
			"[
				return (EIF_POINTER)((llvm::StructType *)$item_a)->getTypeAtIndex ($idx);
			]"
		end

	index_valid_external (item_a: POINTER; idx: NATURAL_32): BOOLEAN
		external
			"C++ inline use %"llvm/DerivedTypes.h%""
		alias
			"[
				return ((llvm::StructType *)$item_a)->indexValid ($idx);
			]"
		end

	make_external (ctx: POINTER; params: POINTER): POINTER
		external
			"C++ inline use %"llvm/DerivedTypes.h%""
		alias
			"[
				return llvm::StructType::get (*((llvm::LLVMContext *)$ctx), *((std::vector <const llvm::Type *> *)$params));
			]"
		end

	make_packed_external (ctx: POINTER; params: POINTER; is_packed: BOOLEAN): POINTER
		external
			"C++ inline use %"llvm/DerivedTypes.h%""
		alias
			"[
				return llvm::StructType::get (*((llvm::LLVMContext *)$ctx), *((std::vector <const llvm::Type *> *)$params), $is_packed);
			]"
		end
end
