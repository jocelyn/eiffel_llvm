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

end


