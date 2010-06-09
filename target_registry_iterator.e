note
	description: "Summary description for {TARGET_REGISTRY_ITERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_REGISTRY_ITERATOR

inherit

	MEMORY_STRUCTURE
		redefine
			is_equal
		end

feature

	item_name: STRING
		local
			c_name: C_STRING
		do
			create c_name.make_shared_from_pointer (item_name_external (item))
			Result := c_name.string
		end

	forth
		do
			forth_external (item)
		end

	is_equal (other_a: like Current): BOOLEAN
		do
			Result := is_equal_external (item, other_a.item)
		end

feature {NONE} -- Externals

	item_name_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				return (EIF_POINTER)(*((llvm::TargetRegistry::iterator *)$item_a))->getName ();
			]"
		end

	forth_external (item_a: POINTER)
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				*((llvm::TargetRegistry::iterator *)$item_a)++;
			]"
		end

	is_equal_external (item_a: POINTER; other_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				return *((llvm::TargetRegistry::iterator *)$item_a) == *((llvm::TargetRegistry::iterator *)$other_a);
			]"
		end

feature {NONE} -- Implementation

	structure_size: INTEGER
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				return sizeof (llvm::TargetRegistry::iterator);
			]"
		end
end
