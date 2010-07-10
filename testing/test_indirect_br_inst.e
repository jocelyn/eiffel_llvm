note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_INDIRECT_BR_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_indirect_br_inst_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b1: BASIC_BLOCK
			b2: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: INDIRECT_BR_INST
			int_to_ptr: INT_TO_PTR_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b1.make (ctx)
			create b2.make_name (ctx, "target")
			f.basic_block_list_push_back (b1)
			f.basic_block_list_push_back (b2)
			m.function_list_push_back (f)
			create int_to_ptr.make (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 0x1000), create {POINTER_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 32)))
			create i.make (int_to_ptr)
			i.add_destination (b2)
			b1.inst_list_push_back (int_to_ptr)
			b1.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_indirect_br_inst_1", s_result ~ test_indirect_br_inst_1_expected)
		end

	test_indirect_br_inst_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  %1 = inttoptr i32 4096 to i32*                  ; <i32*> [#uses=1]
  indirectbr i32* %1, [label %target]

target:                                           ; preds = %0
}

]"

end


