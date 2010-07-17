note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_ICMP_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_icmp_inst_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: ICMP_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
			predicate: PREDICATE_L
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			m.function_list_push_back (f)
			create i.make (predicate.icmp_eq, create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 1), create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 1))
			b.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_icmp_inst_1", s_result ~ test_icmp_inst_1_expected)
		end

	test_icmp_inst_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  %1 = icmp eq i32 1, 1                           ; <i1> [#uses=0]
}

]"

	test_icmp_inst_2
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			t: TYPE_VECTOR
			st: STRUCT_TYPE
			g: GLOBAL_VARIABLE
			ge: GET_ELEMENT_PTR_INST
			i: ICMP_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
			predicate: PREDICATE_L
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			m.function_list_push_back (f)
			create t.make
			t.push_back (create {INTEGER_TYPE}.make (ctx, 32))
			create st.make (ctx, t)
			create g.make (st, True, linkage_types.external_linkage)
			m.global_list_push_back (g)
			create ge.make_index (g, create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 0))
			b.inst_list_push_back (ge)
			create i.make (predicate.icmp_eq, g, ge)
			b.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_icmp_inst_2", s_result ~ test_icmp_inst_2_expected)
		end

	test_icmp_inst_2_expected: STRING_8 =
"[
; ModuleID = 'test'

%0 = type { i32 }

@0 = external constant %0                         ; <%0*> [#uses=2]

define i32 @main() {
  %1 = getelementptr %0* @0, i32 0                ; <%0*> [#uses=1]
  %2 = icmp eq %0* @0, %1                         ; <i1> [#uses=0]
}

]"

end


