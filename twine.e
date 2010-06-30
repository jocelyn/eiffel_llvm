note
	description: "Summary description for {TWINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TWINE

create

	make_from_pointer,
	make

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	make
		do
			item := make_external
		end
		
	make_string (str: STRING)
		local
			str_c_string: C_STRING
		do
			create str_c_string.make (str)
			item := make_string_external (str_c_string.item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	make_string_external (str: POINTER): POINTER
		external
			"C++ inline use %"llvm/ADT/Twine.h%""
		alias
			"[
				return new llvm::Twine ((const char *)$str);
			]"
		end

	make_external: POINTER
		external
			"C++ inline use %"llvm/ADT/Twine.h%""
		alias
			"[
				return new llvm::Twine;		
			]"
		end
end
