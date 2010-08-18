note
	description: "Summary description for {VALUE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VALUE

create

	make_from_pointer

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

feature

	get_raw_type: TYPE_L
		do
			create Result.make_from_pointer (get_raw_type_external (item))
		end

	set_name (name: TWINE)
		do
			set_name_external (item, name.item)
		end

feature

	item: POINTER

feature -- Casting queries

	set_name_external (item_a: POINTER; name: POINTER)
		external
			"C++ inline use %"llvm/Value.h%""
		alias
			"[
				((llvm::Value *)$item_a)->setName (*((llvm::Twine *)$name));
			]"
		end

	class_of_function: BOOLEAN
		do
			Result := class_of_function_external (item)
		end

feature {NONE} -- Externals

	get_raw_type_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/Value.h%""
		alias
			"[
				return (EIF_POINTER)((llvm::Value *)$item_a)->getRawType ();
			]"
		end

	class_of_function_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/Function.h%", %"llvm/Value.h%""
		alias
			"[
				return llvm::Function::classof ((llvm::Value *)$item_a);
			]"
		end

end
