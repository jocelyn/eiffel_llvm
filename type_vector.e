note
	description: "Summary description for {TYPE_VECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_VECTOR

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
			item := ctor_external
		end

feature

	push_back (x: TYPE_L)
		do
			push_back_external (item, x.item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	ctor_external: POINTER
		external
			"C++ inline use <vector>, %"llvm/Type.h%""
		alias
			"[
				return new std::vector <llvm::Type *>;
			]"
		end

	push_back_external (item_a: POINTER; x: POINTER)
		external
			"C++ inline use <vector>, %"llvm/Type.h%""
		alias
			"[
				((std::vector <llvm::Type *> *)$item_a)->push_back ((llvm::Type *)$x);
			]"
		end
end
