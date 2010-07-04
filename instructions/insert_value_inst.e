note
	description: "Summary description for {INSERT_VALUE_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INSERT_VALUE_INST

inherit
	INSTRUCTION

create

	make,
	make_name,
	make_list,
	make_list_name

feature {NONE}

	make (agg: VALUE; val: VALUE; idx: NATURAL_32)
		do
			item := make_external (agg.item, val.item, idx)
		end

	make_name (agg: VALUE; val: VALUE; idx: NATURAL_32; name: TWINE)
		do
			item := make_name_external (agg.item, val.item, idx, name.item)
		end

	make_list (agg: VALUE; idx: LIST [NATURAL_32]; val: VALUE)
		local
			idx_vector: UNSIGNED_VECTOR
		do
			create idx_vector.make
			across idx as idx_item loop idx_vector.push_back (idx_item.item) end
			item := make_list_external (agg.item, val.item, idx_vector.item)
		end

	make_list_name (agg: VALUE; idx: LIST [NATURAL_32]; val: VALUE; name: TWINE)
		local
			idx_vector: UNSIGNED_VECTOR
		do
			create idx_vector.make
			across idx as idx_item loop idx_vector.push_back (idx_item.item) end
			item := make_list_name_external (agg.item, val.item, idx_vector.item, name.item)
		end

feature {NONE} -- Externals

	make_external (agg: POINTER; val: POINTER; idx: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%""
		alias
			"[
				return llvm::InsertValueInst::Create ((llvm::Value *)$agg, (llvm::Value *)$val, $idx);
			]"
		end

	make_name_external (agg: POINTER; val: POINTER; idx: NATURAL_32; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%""
		alias
			"[
				return llvm::InsertValueInst::Create ((llvm::Value *)$agg, (llvm::Value *)$val, $idx, *((llvm::Twine *)$name));
			]"
		end

	make_list_external (agg: POINTER; val: POINTER; idx: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%""
		alias
			"[
				return llvm::InsertValueInst::Create ((llvm::Value *)$agg, (llvm::Value *)$val, ((std::vector <unsigned> *)$idx)->begin (), ((std::vector <unsigned> *)$idx)->end ());
			]"
		end

	make_list_name_external (agg: POINTER; val: POINTER; idx: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%""
		alias
			"[
				return llvm::InsertValueInst::Create ((llvm::Value *)$agg, (llvm::Value *)$val, ((std::vector <unsigned> *)$idx)->begin (), ((std::vector <unsigned> *)$idx)->end (), *((llvm::Twine *)$name));
			]"
		end
end
