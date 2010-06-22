note
	description: "Summary description for {STRING_REF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_REF

create

	make

feature {NONE}

	make (c_string_a: POINTER)
		do
			item := ctor_external (c_string_a)
		end
		
feature {NONE}

	item: POINTER

feature {NONE}

	ctor_external (c_string_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/ADT/StringRef.h%""
		alias
			"[
				return new llvm::StringRef ((const char *)$c_string_a);		
			]"
		end
end
