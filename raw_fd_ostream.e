note
	description: "Summary description for {RAW_FD_OSTREAM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RAW_FD_OSTREAM

inherit
	RAW_OSTREAM

create

	make_filename

feature {NONE}

	make_filename (filename: STRING)
		local
			filename_c_string: C_STRING
		do
			create filename_c_string.make (filename)
			item := ctor_filename_error_info (filename_c_string.item)
		end

feature {NONE} -- Externals

	ctor_filename_error_info (filename: POINTER): POINTER
		external
			"C++ inline use %"llvm/Support/FormattedStream.h%""
		alias
			"[
				std::string error;
				
				return new llvm::raw_fd_ostream ((const char *)$filename, error);
			]"
		end

end
