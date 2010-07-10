note
	description: "Summary description for {CONSTANT_VECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANT_VECTOR

inherit
	CONSTANT

create

	make

feature {NONE}

	make (t: VECTOR_TYPE; v: CONSTANT_STLVECTOR)
		do
			item := make_external (t.item, v.item)
		end

feature {NONE}

	make_external (t: POINTER; v: POINTER): POINTER
		external
			"C++ inline use %"llvm/Constants.h%""
		alias
			"[
				return llvm::ConstantVector::get ((llvm::VectorType *)$t, *((std::vector <llvm::Constant *> *)$v));
			]"
		end

end
