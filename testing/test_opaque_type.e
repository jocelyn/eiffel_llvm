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

	test_opaque_type_2
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			linkage_types: LINKAGE_TYPES
			o: OPAQUE_TYPE
			p: TYPE_VECTOR
			pt: POINTER_TYPE
			i: STRUCT_TYPE
			g: GLOBAL_VARIABLE
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create p.make
			p.push_back (create {INTEGER_TYPE}.make (ctx, 32))
			create o.make (ctx)
			p.push_back (o)
			create i.make (ctx, p)
			create g.make (i, True, linkage_types.external_linkage)
			m.global_list_push_back (g)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_opaque_type_2_1", s_result ~ test_opaque_type_2_1_expected)
			create pt.make (i)
			o.refine_abstract_type_to (pt)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_opaque_type_2_2", s_result ~ test_opaque_type_2_2_expected)
		end

	test_opaque_type_2_1_expected: STRING_8 =
"[
; ModuleID = 'test'

%0 = type { i32, %1 }
%1 = type opaque

@0 = external constant %0                         ; <%0*> [#uses=0]

]"

	test_opaque_type_2_2_expected: STRING_8 =
"[
; ModuleID = 'test'

%0 = type { i32, %0* }

@0 = external constant %0                         ; <%0*> [#uses=0]

]"

	test_opaque_type_3
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			linkage_types: LINKAGE_TYPES
			o: OPAQUE_TYPE
			p: POINTER_TYPE
			g: GLOBAL_VARIABLE
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create o.make (ctx)
			create p.make (o)
			create g.make (p, True, linkage_types.external_linkage)
			m.global_list_push_back (g)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_opaque_type_3_1", s_result ~ test_opaque_type_3_1_expected)
			p.refine_abstract_type_to (create {POINTER_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 32)))
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_opaque_type_3_2", s_result ~ test_opaque_type_3_2_expected)
		end

	test_opaque_type_3_1_expected: STRING_8 =
"[
; ModuleID = 'test'

%0 = type opaque

@0 = external constant %0*                        ; <%0**> [#uses=0]

]"

	test_opaque_type_3_2_expected: STRING_8 =
"[
; ModuleID = 'test'

@0 = external constant i32*                       ; <i32**> [#uses=0]

]"

	test_opaque_type_4
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			linkage_types: LINKAGE_TYPES
			o: OPAQUE_TYPE
			p: POINTER_TYPE
			g: GLOBAL_VARIABLE
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create o.make (ctx)
			create p.make (o)
			create g.make (p, True, linkage_types.external_linkage)
			m.global_list_push_back (g)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_opaque_type_4_1", s_result ~ test_opaque_type_4_1_expected)
			o.refine_abstract_type_to (create {INTEGER_TYPE}.make (ctx, 32))
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_opaque_type_4_2", s_result ~ test_opaque_type_4_2_expected)
		end

	test_opaque_type_4_1_expected: STRING_8 =
"[
; ModuleID = 'test'

%0 = type opaque

@0 = external constant %0*                        ; <%0**> [#uses=0]

]"

	test_opaque_type_4_2_expected: STRING_8 =
"[
; ModuleID = 'test'

@0 = external constant i32*                       ; <i32**> [#uses=0]

]"

	test_opaque_type_5
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			linkage_types: LINKAGE_TYPES
			o: OPAQUE_TYPE
			p: POINTER_TYPE
			g: GLOBAL_VARIABLE
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create o.make (ctx)
			create p.make (o)
			create g.make_initializer (p, True, linkage_types.external_linkage, create {CONSTANT_POINTER_NULL}.make (p))
			m.global_list_push_back (g)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_opaque_type_5_1", s_result ~ test_opaque_type_5_1_expected)
			o.refine_abstract_type_to (create {INTEGER_TYPE}.make (ctx, 32))
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_opaque_type_5_2", s_result ~ test_opaque_type_5_2_expected)
		end

	test_opaque_type_5_1_expected: STRING_8 =
"[
; ModuleID = 'test'

%0 = type opaque

@0 = constant %0* null                            ; <%0**> [#uses=0]

]"

	test_opaque_type_5_2_expected: STRING_8 =
"[
; ModuleID = 'test'

@0 = constant i32* null                           ; <i32**> [#uses=0]

]"

end


