note
	description: "Summary description for {FP_TO_SI_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FP_TO_SI_INST

inherit
	CAST_INST

create

	make,
	make_name

feature {NONE}

	make (s: VALUE; ty: VALUE)
		do
			item := make_external (s.item, ty.item)
		end

	make_name (s: VALUE; ty: VALUE; name: TWINE)
		do
			item := make_name_external (s.item, ty.item, name.item)
		end

feature {NONE} -- Externals

	make_external (s: POINTER; ty: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%""
		alias
			"[
				return new llvm::FPToSIInst ((llvm::Value *)$s, (llvm::Value *)$ty);
			]"
		end

	make_name_external (s: POINTER; ty: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%""
		alias
			"[
				return new llvm::FPToSIInst ((llvm::Value *)$s, (llvm::Value *)$ty, *((llvm::Twine *)$name));
			]"
		end

end