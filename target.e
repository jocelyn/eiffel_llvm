note
	description: "Summary description for {TARGET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET

create

	make_from_pointer,
	default_create

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

feature

	get_name: STRING
		local
			name_pointer: POINTER
			name_c_string: C_STRING
		do
			name_pointer := get_name_external (item)
			create name_c_string.make_shared_from_pointer (name_pointer)
			Result := name_c_string.string
		end

feature {NONE} -- Externals

	get_name_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				return (EIF_POINTER)((llvm::Target *)$item_a)->getName ();
			]"
		end

feature {NONE} -- Implementation

	item: POINTER
end
