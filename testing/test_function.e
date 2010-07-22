note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_FUNCTION

inherit
	EQA_TEST_SET

feature -- Test routines

	test_function_1
		local
			ctx: LLVM_CONTEXT
			t: FUNCTION_TYPE
			t2: FUNCTION_TYPE
			f: FUNCTION_L
			linkage_types: LINKAGE_TYPES
		do
			create ctx
			create t.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32))
			create f.make_name (t, linkage_types.external_linkage, "test")
			t2 := f.get_function_type
			assert ("test_function_1", t2.get_num_params = 0)
		end

end


