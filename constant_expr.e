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

	get_bit_cast

feature {NONE}

	get_bit_cast (c: CONSTANT; ty: TYPE_L)
		do
			item := get_bit_cast_external (c.item, ty.item)
		end

feature {NONE} -- Externals

	get_bit_cast_external (c: POINTER; ty: POINTER): POINTER
		external
			"C++ inline use %"llvm/Constants.h%""
		alias
			"[
				return llvm::ConstantExpr::getBitCast ((llvm::Constant *)$c, (llvm::Type *)$ty);
			]"
		end
end
