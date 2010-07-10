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

	make (func: VALUE; if_normal: BASIC_BLOCK; if_exception: BASIC_BLOCK)
		local
			arguments: VALUE_VECTOR
		do
			create arguments.make
			item := make_external (func.item, if_normal.item, if_exception.item, arguments.item)
		end

	make_arguments (func: VALUE; if_normal: BASIC_BLOCK; if_exception: BASIC_BLOCK; arguments: VALUE_VECTOR)
		do
			item := make_external (func.item, if_normal.item, if_exception.item, arguments.item)
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
