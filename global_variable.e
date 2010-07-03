note
	description: "Summary description for {GLOBAL_VARIABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GLOBAL_VARIABLE

inherit
	GLOBAL_VALUE

create

	make_from_pointer,
	make,
	make_initializer,
	make_initializer_name,
	make_initializer_name_thread_local

feature {NONE}

	make (ty: TYPE; is_constant: BOOLEAN; linkage: INTEGER_32)
		do
			item := make_external (ty.item, is_constant, linkage)
		end

	make_initializer (ty: TYPE; is_constant: BOOLEAN; linkage: INTEGER_32; initializer: CONSTANT)
		do
			item := make_initializer_external (ty.item, is_constant, linkage, initializer.item)
		end

	make_initializer_name (ty: TYPE; is_constant: BOOLEAN; linkage: INTEGER_32; initializer: CONSTANT; name: TWINE)
		do
			item := make_initializer_name_external (ty.item, is_constant, linkage, initializer.item, name.item)
		end

	make_initializer_name_thread_local (ty: TYPE; is_constant: BOOLEAN; linkage: INTEGER_32; initializer: CONSTANT; name: TWINE; thread_local: BOOLEAN)
		do
			item := make_initializer_name_thread_local_external (ty.item, is_constant, linkage, initializer.item, name.item, thread_local)
		end

feature {NONE} -- Externals

	make_external (ty: POINTER; is_constant: BOOLEAN; linkage: INTEGER_32): POINTER
		external
			"C++ inline use %"llvm/GlobalVariable.h%""
		alias
			"[
				return new llvm::GlobalVariable ((llvm::Type *)$ty, $is_constant, (llvm::GlobalValue::LinkageTypes)$linkage);
			]"
		end

	make_initializer_external (ty: POINTER; is_constant: BOOLEAN; linkage: INTEGER_32; initializer: POINTER): POINTER
		external
			"C++ inline use %"llvm/GlobalVariable.h%""
		alias
			"[
				return new llvm::GlobalVariable ((llvm::Type *)$ty, $is_constant, (llvm::GlobalValue::LinkageTypes)$linkage, (llvm::Constant *)$initializer);
			]"
		end

	make_initializer_name_external (ty: POINTER; is_constant: BOOLEAN; linkage: INTEGER_32; initializer: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/GlobalVariable.h%""
		alias
			"[
				return new llvm::GlobalVariable ((llvm::Type *)$ty, $is_constant, (llvm::GlobalValue::LinkageTypes)$linkage, (llvm::Constant *)$initializer, *((llvm::Twine *)$name));
			]"
		end

	make_initializer_name_thread_local_external (ty: POINTER; is_constant: BOOLEAN; linkage: INTEGER_32; initializer: POINTER; name: POINTER; thread_local: BOOLEAN): POINTER
		external
			"C++ inline use %"llvm/GlobalVariable.h%""
		alias
			"[
				return new llvm::GlobalVariable ((llvm::Type *)$ty, $is_constant, (llvm::GlobalValue::LinkageTypes)$linkage, (llvm::Constant *)$initializer, *((llvm::Twine *)$name), $thread_local);
			]"
		end
end
