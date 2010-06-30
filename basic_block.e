note
	description: "Summary description for {BASIC_BLOCK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_BLOCK

inherit

	VALUE

create

	make_from_pointer

feature

	inst_list_push_back (v: INSTRUCTION)
		do
			inst_list_push_back_external (item, v.item)
		end

feature {NONE} -- Externals

	inst_list_push_back_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use %"llvm/BasicBlock.h%""
		alias
			"[
				((llvm::BasicBlock *)$item_a)->getInstList ().push_back ((llvm::Instruction *)$v);		
			]"
		end
end
