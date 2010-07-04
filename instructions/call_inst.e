note
	description: "Summary description for {CALL_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALL_INST

inherit
	INSTRUCTION

create

	make_from_pointer,
	make,
	make_name,
	make_arguments,
	make_arguments_name

feature {NONE}

	make (f: VALUE)
		do
			item := make_external (f.item)
		end

	make_name (f: VALUE; name: TWINE)
		do
			item := make_name_external (f.item, name.item)
		end

	make_arguments (f: VALUE; args: VALUE_VECTOR)
		do
			item := make_arguments_external (f.item, args.item)
		end

	make_arguments_name (f: VALUE; args: VALUE_VECTOR; name: TWINE)
		do
			item := make_arguments_name_external (f.item, args.item, name.item)
		end

feature {NONE} -- Externals

	make_external (f: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%""
		alias
			"[
				return llvm::CallInst::Create ((llvm::Value *)$f);
			]"
		end

	make_name_external (f: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%""
		alias
			"[
				return llvm::CallInst::Create ((llvm::Value *)$f, *((llvm::Twine *)$name));
			]"
		end

	make_arguments_external (f: POINTER; args: POINTER): POINTER
		external
			"C++ inline use <vector>, %"llvm/Instructions.h%""
		alias
			"[
				return llvm::CallInst::Create ((llvm::Value *)$f, ((std::vector <llvm::Value *> *)$args)->begin (), ((std::vector <llvm::Value *> *)$args)->end ());
			]"
		end

	make_arguments_name_external (f: POINTER; args: POINTER; name: POINTER): POINTER
		external
			"C++ inline use <vector>, %"llvm/Instructions.h%""
		alias
			"[
				return llvm::CallInst::Create ((llvm::Value *)$f, ((std::vector <llvm::Value *> *)$args)->begin (), ((std::vector <llvm::Value *> *)$args)->end (), *((llvm::Twine *)$name));
			]"
		end
end
