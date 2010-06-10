note
	description: "Summary description for {RAW_OSTREAM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RAW_OSTREAM

inherit

	DISPOSABLE

feature

	item: POINTER

feature

	flush
		do
			flush_external (item)
		end

feature {NONE} -- Externals

	dispose
		do
			delete (item)
			item := default_pointer
		end

	flush_external (item_a: POINTER)
		external
			"C++ inline use %"llvm/Support/FormattedStream.h%""
		alias
			"[
				((llvm::raw_ostream *)$item_a)->flush ();
			]"
		end

	delete (item_a: POINTER)
		external
			"C++ inline use %"llvm/Support/FormattedStream.h%""
		alias
			"[
				delete (llvm::raw_ostream *)$item_a;
			]"
		end
end
