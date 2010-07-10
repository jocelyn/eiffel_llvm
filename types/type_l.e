note
	description: "Summary description for {TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_L

create

	make_from_pointer,
	make_void,
	make_double,
	make_float

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	make_void (ctx: LLVM_CONTEXT)
		do
			item := make_void_external (ctx.item)
		end

	make_double (ctx: LLVM_CONTEXT)
		do
			item := make_double_external (ctx.item)
		end
		
	make_float (ctx: LLVM_CONTEXT)
		do
			item := make_float_external (ctx.item)
		end

feature

	get_type_id: INTEGER_32
		do
			Result := get_type_id_external (item)
		end

feature

	item: POINTER

feature -- Casting queries

	make_float_external (ctx: POINTER): POINTER
		external
			"C++ inline use %"llvm/Type.h%""
		alias
			"[
				return (EIF_POINTER)llvm::Type::getFloatTy (*((llvm::LLVMContext *)$ctx));
			]"
		end

	make_double_external (ctx: POINTER): POINTER
		external
			"C++ inline use %"llvm/Type.h%""
		alias
			"[
				return (EIF_POINTER)llvm::Type::getDoubleTy (*((llvm::LLVMContext *)$ctx));
			]"
		end

	classof_integer_type: BOOLEAN
		do
			Result := classof_integer_type_external (item)
		end

	classof_vector_type: BOOLEAN
		do
			Result := classof_vector_type_external (item)
		end

feature {NONE} -- Externals

	classof_vector_type_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/Type.h%""
		alias
			"[
				return llvm::VectorType::classof ((llvm::Type *)$item_a);
			]"
		end

	get_type_id_external (item_a: POINTER): INTEGER_32
		external
			"C++ inline use %"llvm/Type.h%""
		alias
			"[
				return ((llvm::Type *)$item_a)->getTypeID ();
			]"
		end

	classof_integer_type_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/Type.h%""
		alias
			"[
				return llvm::IntegerType::classof ((llvm::Type *)$item_a);
			]"
		end

	make_void_external (ctx: POINTER): POINTER
		external
			"C++ inline use %"llvm/Type.h%""
		alias
			"[
				return (EIF_POINTER)llvm::Type::getVoidTy (*((llvm::LLVMContext *)$ctx));
			]"
		end
end
