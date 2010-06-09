note
	description: "Summary description for {LLVM_CONTEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LLVM_CONTEXT

create

	make_from_pointer

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

feature

	item: POINTER
end
