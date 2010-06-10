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

	dispose
		do
			if item /= default_pointer then
				delete (item)
				item := default_pointer
			end
		end

feature {NONE} -- Externals

	delete (item_a: POINTER)
		external
			"C++ inline use %"llvm/Support/FormattedStream.h%""
		alias
			"[
				delete (llvm::raw_ostream *)$item_a;		
			]"
		end
end
