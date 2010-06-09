note
	description: "Summary description for {SM_DIAGNOSTIC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SM_DIAGNOSTIC

create

	make_from_pointer,
	make

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	make
		do

		end


feature

	item: POINTER
end
