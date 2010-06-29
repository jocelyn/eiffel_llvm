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

	item: POINTER

feature -- Casting queries

	class_of_function: BOOLEAN
		do
			Result := class_of_function_external (item)
		end

feature {NONE} -- Externals

	class_of_function_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/Function.h%", %"llvm/Value.h%""
		alias
			"[
				return llvm::Function::classof ((llvm::Value *)$item_a);
			]"
		end

end
