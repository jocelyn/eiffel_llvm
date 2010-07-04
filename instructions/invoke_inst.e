note
	description: "Summary description for {INVOKE_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INVOKE_INST

inherit
	TERMINATOR_INST

create

	make

feature {NONE}

	make (func: VALUE; if_normal: BASIC_BLOCK; if_exception: BASIC_BLOCK; arguments: LIST [VALUE])
		local
			arguments_vector: VALUE_VECTOR
		do
			create arguments_vector.make
			across arguments as argument_item loop arguments_vector.push_back (argument_item.item) end
			item := make_external (func.item, if_normal.item, if_exception.item, arguments_vector.item)
		end

feature {NONE}

	make_external (func: POINTER; if_normal: POINTER; if_exception: POINTER; arguments: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%""
		alias
			"[
				return llvm::InvokeInst::Create  ((llvm::Value *)$func, (llvm::BasicBlock *)$if_normal, (llvm::BasicBlock *)$if_exception, ((std::vector <llvm::Value *> *)$arguments)->begin (), ((std::vector <llvm::Value *> *)$arguments)->end ());
			]"
		end
end
