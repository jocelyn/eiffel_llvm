note
	description: "Summary description for {POINTER_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POINTER_TYPE

inherit
	SEQUENTIAL_TYPE

create

	make_from_pointer,
	make

feature {NONE}

	make (element_type: TYPE_L)
		do
			item := make_external (element_type.item)
		end

feature {NONE} -- Externals

	make_external (element_type: POINTER): POINTER
		external
			"C++ inline use %"llvm/DerivedTypes.h%""
		alias
			"[
				return llvm::PointerType::getUnqual ((const llvm::Type *)$element_type);
			]"
		end
end
