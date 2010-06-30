note
	description: "Summary description for {VALUE_VECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VALUE_VECTOR

create

	make,
	make_from_pointer

feature {NONE}

	make
		do
			item := make_external
		end

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end
		
feature

	push_back (v: VALUE)
		do
			push_back_external (item, v.item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	push_back_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use <vector>, %"llvm/Value.h%""
		alias
			"[
				((std::vector <llvm::Value *> *)$item_a)->push_back ((llvm::Value *)$v);
			]"
		end

	make_external: POINTER
		external
			"C++ inline use <vector>, %"llvm/Value.h%""
		alias
			"[
				return new std::vector <llvm::Value *>;
			]"
		end
end
