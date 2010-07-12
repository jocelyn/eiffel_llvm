note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_OPAQUE_TYPE

inherit
	EQA_TEST_SET

feature -- Test routines

	test_opaque_type_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			linkage_types: LINKAGE_TYPES
			t: TYPE_VECTOR
			st: STRUCT_TYPE
			g: GLOBAL_VARIABLE
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create t.make
			t.push_back (create {INTEGER_TYPE}.make (ctx, 32))
			t.push_back (create {OPAQUE_TYPE}.make (ctx))
			create st.make (ctx, t)
			create g.make (st, True, linkage_types.external_linkage)
			m.global_list_push_back (g)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_opaque_type_1", s_result ~ test_opaque_type_1_expected)
		end

	test_opaque_type_1_expected: STRING_8 =
"[
; ModuleID = 'test'

%0 = type { i32, %1 }
%1 = type opaque

@0 = external constant %0                         ; <%0*> [#uses=0]

]"

end


