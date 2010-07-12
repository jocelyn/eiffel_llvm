note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_TYPE

inherit
	EQA_TEST_SET

feature -- Test routines

	test_get_type_id
		local
			ctx: LLVM_CONTEXT
			t: INTEGER_TYPE
			type_id: TYPE_ID
		do
			create ctx
			create t.make (ctx, 32)
			assert ("get_type_id", t.get_type_id = type_id.integer_ty_id)
		end

	test_print
		local
			ctx: LLVM_CONTEXT
			t: TYPE_L
			s: RAW_STRING_OSTREAM
		do
			create ctx
--			create {STRUCT_TYPE}t.make (ctx, 32)
			create s.make

		end

end


