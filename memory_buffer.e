note
	description: "Summary description for {MEMORY_BUFFER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MEMORY_BUFFER

create

	make_from_pointer,
	get_file,
	get_mem_buffer_copy

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	get_file (filename: STRING)
		local
			filename_c_string: C_STRING
		do
			create filename_c_string.make (filename)
			item := get_file_external (filename_c_string.item)
		end

	get_mem_buffer_copy (buffer: STRING)
		local
			buffer_c_string: C_STRING
		do
			create buffer_c_string.make (buffer)
			item := get_mem_buffer_copy_external (buffer_c_string.item)
		end

feature

	get_buffer_size: INTEGER_32
		do
			Result := get_buffer_size_external (item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	get_mem_buffer_copy_external (buffer: POINTER): POINTER
		external
			"C++ inline use %"llvm/Support/MemoryBuffer.h%", %"llvm/ADT/StringRef.h%""
		alias
			"[
				llvm::StringRef buffer ((const char *)$buffer);
				llvm::MemoryBuffer * result;
						
				return llvm::MemoryBuffer::getMemBufferCopy (buffer);
			]"
		end

	get_buffer_size_external (item_a: POINTER): INTEGER_32
		external
			"C++ inline use %"llvm/Support/MemoryBuffer.h%""
		alias
			"[
				return ((llvm::MemoryBuffer *)$item_a)->getBufferSize ();
			]"
		end

	get_file_external (filename: POINTER): POINTER
		external
			"C++ inline use %"llvm/Support/MemoryBuffer.h%""
		alias
			"[
				std::string filename ((const char *)$filename);
				
				return llvm::MemoryBuffer::getFile (filename);
			]"
		end
end
