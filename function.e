note
	description: "Summary description for {FUNCTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FUNCTION

inherit
	GLOBAL_VALUE

create

	make_from_pointer,
	cast_from

feature {NONE}

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

	basic_block_list_push_back (v: BASIC_BLOCK)
		do
			basic_block_list_push_back_external (item, v.item)
		end

feature {NONE} -- Externals

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
