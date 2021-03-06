note
	description: "Summary description for {FADD_OPERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FADD_OPERATOR

inherit
	BINARY_OPERATOR

create

	make,
	make_name

feature {NONE}

	make_external (v1: POINTER; v2: POINTER): POINTER
		external
			"C++ inline use %"llvm/InstrTypes.h%""
		alias
			"[
				return llvm::BinaryOperator::CreateFAdd ((llvm::Value *)$v1, (llvm::Value *)$v2);
			]"
		end

	make_name_external (v1: POINTER; v2: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/InstrTypes.h%""
		alias
			"[
				return llvm::BinaryOperator::CreateFAdd ((llvm::Value *)$v1, (llvm::Value *)$v2, *((llvm::Twine *)$name));
			]"
		end
end
