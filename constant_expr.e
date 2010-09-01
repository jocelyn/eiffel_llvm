note
	description: "Summary description for {CONSTANT_EXPR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANT_EXPR

inherit
	CONSTANT

create

	get_bit_cast,
	get_get_element_ptr_single

feature {NONE}

	get_bit_cast (c: CONSTANT; ty: TYPE_L)
		do
			item := get_bit_cast_external (c.item, ty.item)
		end

	get_get_element_ptr_single (c: CONSTANT; idx: SPECIAL [POINTER])
		do
			item := get_get_element_ptr_external (c.item, idx.base_address, idx.count.to_natural_32)
		end

feature {NONE} -- Externals

	get_get_element_ptr_external (c: POINTER; idx_list: POINTER; idx_count: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/Constants.h%", <vector>"
		alias
			"[
				return llvm::ConstantExpr::getGetElementPtr ((llvm::Constant *)$c, (llvm::Constant **)$idx_list, $idx_count);
			]"
		end

	get_bit_cast_external (c: POINTER; ty: POINTER): POINTER
		external
			"C++ inline use %"llvm/Constants.h%""
		alias
			"[
				return llvm::ConstantExpr::getBitCast ((llvm::Constant *)$c, (llvm::Type *)$ty);
			]"
		end
end
