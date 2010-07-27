note
	description: "Summary description for {FUNCTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FUNCTION_L

inherit
	GLOBAL_VALUE

	DEBUG_OUTPUT

create

	make,
	make_name,
	make_from_pointer,
	cast_from

feature {NONE}

	make (ty: FUNCTION_TYPE; linkage: INTEGER_32)
		do
			item := make_external (ty.item, linkage)
		end

	make_name (ty: FUNCTION_TYPE; linkage: INTEGER_32; n: TWINE)
		do
			item := make_name_external (ty.item, linkage, n.item)
		end

	cast_from (v: VALUE)
		require
			v.class_of_function
		do
			item := v.item
		end

feature

	add_fn_attr (n: NATURAL_32)
		do
			add_fn_attr_external (item, n)
		end

	add_attribute (i: NATURAL_32; n: NATURAL_32)
		do
			add_attribute_external (item, i, n)
		end

	argument_list_push_back (v: ARGUMENT)
		do
			argument_list_push_back_external (item, v.item)
		end

	basic_block_list_push_back (v: BASIC_BLOCK)
		do
			basic_block_list_push_back_external (item, v.item)
		end

	get_function_type: FUNCTION_TYPE
		do
			create Result.make_from_pointer (get_function_type_external (item))
		end

feature

	debug_output: STRING_8
		do
			Result := get_function_type.get_description.string
		end

feature {NONE} -- Externals

	get_function_type_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/Function.h%""
		alias
			"[
				return (EIF_POINTER)((llvm::Function *)$item_a)->getFunctionType ();
			]"
		end

	argument_list_push_back_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use %"llvm/Function.h%""
		alias
			"[
				((llvm::Function *)$item_a)->getArgumentList ().push_back ((llvm::Argument *)$v);
			]"
		end

	make_external (ty: POINTER; linkage: INTEGER_32): POINTER
		external
			"C++ inline use %"llvm/Function.h%""
		alias
			"[
				return llvm::Function::Create ((const llvm::FunctionType *)$ty, (llvm::GlobalValue::LinkageTypes)$linkage);
			]"
		end

	make_name_external (ty: POINTER; linkage: INTEGER_32; n: POINTER): POINTER
		external
			"C++ inline use %"llvm/Function.h%""
		alias
			"[
				return llvm::Function::Create ((const llvm::FunctionType *)$ty, (llvm::GlobalValue::LinkageTypes)$linkage, *((llvm::Twine *)$n));
			]"
		end

	basic_block_list_push_back_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use %"llvm/Function.h%""
		alias
			"[
				((llvm::Function *)$item_a)->getBasicBlockList ().push_back ((llvm::BasicBlock *)$v);
			]"
		end

	add_attribute_external (item_a: POINTER; i: NATURAL_32; n: NATURAL_32)
		external
			"C++ inline use %"llvm/Function.h%""
		alias
			"[
				((llvm::Function *)$item_a)->addAttribute ($i, $n);
			]"
		end

	add_fn_attr_external (item_a: POINTER; n: NATURAL_32)
		external
			"C++ inline use %"llvm/Function.h%""
		alias
			"[
				((llvm::Function *)$item_a)->addFnAttr ($n)
			]"
		end
end
