note
	description: "Summary description for {CPP_STRING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CPP_STRING

create

	make_from_pointer,
	make,
	make_size_char

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	make
		do
			item := ctor_external
		end

	make_size_char (size: INTEGER; char: CHARACTER_8)
		do
			item := ctor_size_char_external (size, char)
		ensure
			length = size
		end

feature

	string: STRING
		local
			result_c_string: C_STRING
		do
			create result_c_string.make_shared_from_pointer (c_str_external (item))
			Result := result_c_string.string
		end

	length: INTEGER
		do
			Result := length_external (item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	length_external (item_a: POINTER): INTEGER
		external
			"C++ inline use <string>"
		alias
			"[
				return ((std::string *)$item_a)->length ();		
			]"
		end

	ctor_size_char_external (size: INTEGER; char: CHARACTER_8): POINTER
		external
			"C++ inline use <string>"
		alias
			"[
				return new std::string ($size, $char);		
			]"
		end

	ctor_external: POINTER
		external
			"C++ inline use <string>"
		alias
			"[
				return new std::string;
			]"
		end

	c_str_external (item_a: POINTER): POINTER
		external
			"C++ inline use <string>"
		alias
			"[
				return (EIF_POINTER)((std::string *)$item_a)->c_str ();		
			]"
		end
end
