note
	description: "Summary description for {GET_ELEMENT_PTR_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GET_ELEMENT_PTR_INST

inherit
	INSTRUCTION

create

	make_from_pointer,
	make_index,
	make_index_name,
	make_index_list,
	make_index_list_name,
	make_inbounds_index,
	make_inbounds_index_name,
	make_inbounds_index_list,
	make_inbounds_index_list_name

feature {NONE}

	make_index (ptr: VALUE; idx: VALUE)
		do
			item := make_index_external (ptr.item, idx.item)
		end

	make_index_name (ptr: VALUE; idx: VALUE; name: TWINE)
		do
			item := make_index_name_external (ptr.item, idx.item, name.item)
		end

	make_index_list (ptr: VALUE; idx: LIST [VALUE])
		local
			idx_vector: VALUE_VECTOR
		do
			create idx_vector.make
			across idx as idx_item loop idx_vector.push_back (idx_item.item) end
			item := make_index_list_external (ptr.item, idx_vector.item)
		end

	make_index_list_name (ptr: VALUE; idx: LIST [VALUE]; name: TWINE)
		local
			idx_vector: VALUE_VECTOR
		do
			create idx_vector.make
			across idx as idx_item loop idx_vector.push_back (idx_item.item) end
			item := make_index_list_name_external (ptr.item, idx_vector.item, name.item)
		end

	make_inbounds_index (ptr: VALUE; idx: VALUE)
		do
			item := make_inbounds_index_external (ptr.item, idx.item)
		end

	make_inbounds_index_name (ptr: VALUE; idx: VALUE; name: TWINE)
		do
			item := make_inbounds_index_name_external (ptr.item, idx.item, name.item)
		end

	make_inbounds_index_list (ptr: VALUE; idx: LIST [VALUE])
		local
			idx_vector: VALUE_VECTOR
		do
			create idx_vector.make
			across idx as idx_item loop idx_vector.push_back (idx_item.item) end
			item := make_inbounds_index_list_external (ptr.item, idx_vector.item)
		end

	make_inbounds_index_list_name (ptr: VALUE; idx: LIST [VALUE]; name: TWINE)
		local
			idx_vector: VALUE_VECTOR
		do
			create idx_vector.make
			across idx as idx_item loop idx_vector.push_back (idx_item.item) end
			item := make_inbounds_index_list_name_external (ptr.item, idx_vector.item, name.item)
		end

feature {NONE} -- Externals

	make_index_external (ptr: POINTER; idx: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%""
		alias
			"[
				return llvm::GetElementPtrInst::Create ((llvm::Value *)$ptr, (llvm::Value *)$idx);
			]"
		end

	make_index_name_external (ptr: POINTER; idx: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%""
		alias
			"[
				return llvm::GetElementPtrInst::Create ((llvm::Value *)$ptr, (llvm::Value *)$idx, *((llvm::Twine *)$name));
			]"
		end

	make_index_list_external (ptr: POINTER; idx: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%", <vector>"
		alias
			"[
				return llvm::GetElementPtrInst::Create ((llvm::Value *)$ptr, ((std::vector <llvm::Value *> *)$idx)->begin (), ((std::vector <llvm::Value *> *)$idx)->end ());
			]"
		end

	make_index_list_name_external (ptr: POINTER; idx: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%", <vector>"
		alias
			"[
				return llvm::GetElementPtrInst::Create ((llvm::Value *)$ptr, ((std::vector <llvm::Value *> *)$idx)->begin (), ((std::vector <llvm::Value *> *)$idx)->end (), *((llvm::Twine *)$name));
			]"
		end

	make_inbounds_index_external (ptr: POINTER; idx: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%""
		alias
			"[
				return llvm::GetElementPtrInst::CreateInBounds ((llvm::Value *)$ptr, (llvm::Value *)$idx);
			]"
		end

	make_inbounds_index_name_external (ptr: POINTER; idx: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%""
		alias
			"[
				return llvm::GetElementPtrInst::CreateInBounds ((llvm::Value *)$ptr, (llvm::Value *)$idx, *((llvm::Twine *)$name));
			]"
		end

	make_inbounds_index_list_external (ptr: POINTER; idx: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%", <vector>"
		alias
			"[
				return llvm::GetElementPtrInst::CreateInBounds ((llvm::Value *)$ptr, ((std::vector <llvm::Value *> *)$idx)->begin (), ((std::vector <llvm::Value *> *)$idx)->end ());
			]"
		end

	make_inbounds_index_list_name_external (ptr: POINTER; idx: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/Instructions.h%", <vector>"
		alias
			"[
				return llvm::GetElementPtrInst::CreateInBounds ((llvm::Value *)$ptr, ((std::vector <llvm::Value *> *)$idx)->begin (), ((std::vector <llvm::Value *> *)$idx)->end (), *((llvm::Twine *)$name));
			]"
		end
end
