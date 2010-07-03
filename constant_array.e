note
	description: "Summary description for {CONSTANT_ARRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANT_ARRAY

inherit
	CONSTANT

create

	make

feature {NONE}

	make (t: ARRAY_TYPE; v: SPECIAL [CONSTANT])
		do
			item := make_external (t.item, v.base_address, v.count.to_natural_32)
		end

feature {NONE} -- Externals

	make_external (t: POINTER; v: POINTER; num_vals: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/Constants.h%""
		alias
			"[
				return llvm::ConstantArray::get ((const llvm::ArrayType *)$t, (llvm::Constant * const *)$v, $num_vals);		
			]"
		end
end
