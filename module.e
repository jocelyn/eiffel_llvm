note
	description: "Summary description for {MODULE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MODULE

create

	make_from_pointer,
	parse_ir_file

feature {NONE} -- Creation

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	parse_ir_file (filename_a: STRING; err: SM_DIAGNOSTIC; context: LLVM_CONTEXT)
		local
			err_pointer: POINTER
			context_pointer: POINTER
			filename_c_string: C_STRING
			result_pointer: POINTER
		do
			create filename_c_string.make (filename_a)
			err_pointer := err.item
			context_pointer := context.item
			result_pointer := parse_ir_file_external (filename_c_string.item, $err_pointer, $context_pointer)
		end

feature


feature {NONE} -- Externals

	parse_ir_file_external (filename_a: POINTER; err: POINTER; context: POINTER): POINTER
		external
			"C++ inline use %"IRReader.h%""
		alias
			"[
				std::string filename ((const char *)$filename_a);		
				
				return ParseIRFile (filename, **((SMDiagnostic **)$err), **((LLVMContext **)$context));
			]"
		end

feature {NONE} -- Implementation

	item: POINTER
end
