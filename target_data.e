note
	description: "Summary description for {TARGET_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_DATA

inherit

	IMMUTABLE_PASS

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

feature

	get_type_alloc_size (ty: TYPE_L): NATURAL_64
		do
			Result := get_type_alloc_size_external (item, ty.item)
		end

feature {NONE} -- Externals

	get_type_alloc_size_external (item_a: POINTER; ty: POINTER): NATURAL_64
		external
			"C++ inline use %"llvm/Target/TargetData.h%""
		alias
			"[
				return ((llvm::TargetData *)$item_a)->getTypeAllocSize ((llvm::Type *)$ty);
			]"
		end

	ctor_module_external (module: POINTER): POINTER
		external
			"C++ inline use %"llvm/Target/TargetData.h%", %"llvm/Module.h%""
		alias
			"[
				return new llvm::TargetData ((llvm::Module *)$module);
			]"
		end
end
