note
	description: "Summary description for {INTRINSIC_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTRINSIC_INST

inherit
	CALL_INST
		rename
			make_external as make_external_call
		end

feature {NONE} -- Externals

	make_external (m: POINTER; id: NATURAL_32; tys: POINTER; num_tys: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/IntrinsicInst.h%""
		alias
			"[
				return llvm::Intrinsic::getDeclaration ((llvm::Module *)$m, (llvm::Intrinsic::ID)$id, (const llvm::Type **)$tys, $num_tys)
			]"
		end

end
