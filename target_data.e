note
	description: "Summary description for {TARGET_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_DATA

inherit

	PASS

create

	make_module,
	make_from_pointer

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	make_module (m: MODULE)
		do
			item := ctor_module_external (m.item)
		end

feature {NONE} -- Externals

	ctor_module_external (module: POINTER): POINTER
		external
			"C++ inline use %"llvm/Target/TargetData.h%", %"llvm/Module.h%""
		alias
			"[
				return new llvm::TargetData ((llvm::Module *)$module);
			]"
		end
end
