note
	description: "Summary description for {MC_CONTEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MC_CONTEXT

create

	make

feature {NONE}

	make (mai: MC_ASM_INFO)
		do
			item := ctor_external (mai.item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	ctor_external (mai: POINTER): POINTER
		external
			"C++ inline use %"llvm/MC/MCContext.h%""
		alias
			"[
				return new llvm::MCContext (*((llvm::MCAsmInfo *)$mai));
			]"
		end
end
