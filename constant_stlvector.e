note
	description: "Summary description for {VECTOR_CONSTANT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANT_STLVECTOR

create

	make

feature {NONE}

	make
		do
			item := ctor_external
		end

feature

	push_back (v: CONSTANT)
		do
			push_back_external (item, v.item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	push_back_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use <vector>, %"llvm/Constant.h%""
		alias
			"[
				((std::vector <llvm::Constant *> *)$item_a)->push_back ((llvm::Constant *)$v);
			]"
		end

	ctor_external: POINTER
		external
			"C++ inline use <vector>, %"llvm/Constant.h%""
		alias
			"[
				return new std::vector <llvm::Constant *>;
			]"
		end

end
