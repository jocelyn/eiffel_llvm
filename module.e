note
	description: "Summary description for {MODULE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MODULE

create

	make,
	make_from_pointer,
--	parse_ir_file
	parse_assembly

feature {NONE} -- Creation

	make (module_id: STRING; context: LLVM_CONTEXT)
		local
			module_id_c_string: C_STRING
			module_id_str_ref: STRING_REF
		do
			create module_id_c_string.make (module_id)
			create module_id_str_ref.make (module_id_c_string.item)

		end

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

--	parse_ir_file (filename_a: STRING; err: SM_DIAGNOSTIC; context: LLVM_CONTEXT)
--		local
--			filename_c_string: C_STRING
--			result_pointer: POINTER
--		do
--			create filename_c_string.make (filename_a)
--			result_pointer := parse_ir_file_external (filename_c_string.item, err.item, context.item)
--		end

	parse_assembly (buffer: MEMORY_BUFFER; err: SM_DIAGNOSTIC; context: LLVM_CONTEXT)
		do
			item := parse_assembly_external (buffer.item, default_pointer, err.item, context.item)
			if item = default_pointer then
				(create {EXCEPTION}).raise
			end
		end

feature

	get_target_triple: STRING
		local
			c_result: C_STRING
		do
			create c_result.own_from_pointer (get_target_triple_external (item))
			Result := c_result.string
		end

	write_bit_code_to_file (output: RAW_OSTREAM)
		do
			write_bit_code_to_file_external (item, output.item)
		end

	module_identifier: STRING
		local
			external_string: CPP_STRING
		do
			create external_string.make
			module_identifier_external (item, external_string.item)
		end

feature {NONE} -- Externals

	ctor_external (module_id: POINTER; context: POINTER): POINTER
		external
			"C++ inline use %"llvm/Module.h%""
		alias
			"[
				return new llvm::Module (*((llvm::StringRef *)$module_id), *((llvm::LLVMContext *)$context))
			]"
		end

	module_identifier_external (item_a: POINTER; target_a: POINTER)
		external
			"C++ inline use %"llvm/Module.h%""
		alias
			"[
				*((std::string *)$target_a) = ((llvm::Module *)$item_a)->getModuleIdentifier ();
			]"
		end

	write_bit_code_to_file_external (item_a: POINTER; output: POINTER)
		external
			"C++ inline use %"llvm/Bitcode/ReaderWriter.h%""
		alias
			"[
				llvm::WriteBitcodeToFile (((llvm::Module *)$item_a), *((llvm::raw_ostream *)$output));
			]"
		end

	get_target_triple_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/Module.h%""
		alias
			"[
				std::string triple;
				char * result;
				size_t result_size;
				
				triple = ((llvm::Module *)$item_a)->getTargetTriple ();
				result_size = triple.length ();
				result = (char *)malloc (result_size);
				strncpy (result, triple.c_str (), result_size);
				
				return result;
			]"
		end

	parse_assembly_external (buffer: POINTER; module: POINTER; err: POINTER; context: POINTER): POINTER
		external
			"C++ inline use %"llvm/Assembly/Parser.h%", %"llvm/Module.h%", %"llvm/Support/SourceMgr.h%", %"llvm/Support/MemoryBuffer.h%""
		alias
			"[
				return llvm::ParseAssembly ((llvm::MemoryBuffer *)$buffer, (llvm::Module *)$module, *((llvm::SMDiagnostic *)$err), *((llvm::LLVMContext *)$context));
			]"
		end

--	parse_ir_file_external (filename_a: POINTER; err: POINTER; context: POINTER): POINTER
--		external
--			"C++ inline use %"llvm/LLVMContext.h%", %"llvm/Support/IRReader.h%""
--		alias
--			"[
--				std::string filename ((const char *)$filename_a);		
--				
--				return ParseIRFile (filename, *((SMDiagnostic *)$err), *((LLVMContext *)$context));
--			]"
--		end

feature -- Implementation

	item: POINTER
end
