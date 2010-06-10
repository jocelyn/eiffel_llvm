note
	description : "llvm_test application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make2
		local
			tr: TARGET_REGISTRY_CLASS
			it: TARGET_REGISTRY_ITERATOR
		do
			tr.initialize_all_targets
			from
				it := tr.begin
			until
				it ~ tr.end_item
			loop
				io.put_string (it.target.get_name)
				it.forth
			end
		end

	make
			-- Run application.
		local
			tr: TARGET_REGISTRY_CLASS
			target: TARGET
			iterator: TARGET_REGISTRY_ITERATOR
			name: STRING
			module: MODULE
			diag: SM_DIAGNOSTIC
			context: LLVM_CONTEXT
			buff: MEMORY_BUFFER
			buff_size: INTEGER_32
			machine: TARGET_MACHINE
--			fd_stream: RAW_FD_OSTREAM
			fd_stream: RAW_STRING_OSTREAM
			formatted_stream: FORMATTED_RAW_OSTREAM
			pm: PASS_MANAGER
			td: TARGET_DATA
			verifier: FUNCTION_PASS
			triple_string: STRING
			assembly_buffer: MEMORY_BUFFER
			binary_buffer: RAW_STRING_OSTREAM
			output_buffer: FORMATTED_RAW_OSTREAM
		do
			io.put_string ("")
			tr.initialize_all_targets
			tr.initialize_all_asm_printers
			--create buff.get_file ("/Users/colinlemahieu/Desktop/test.o.ll")
			create buff.get_mem_buffer_copy (assembly_code)
			create diag
			create context
			create module.parse_assembly (buff, diag, context)
			triple_string := module.get_target_triple
			target := tr.lookup_target (triple_string)
			machine := target.create_target_machine (triple_string, "")
--			create fd_stream.make_filename ("/Users/colinlemahieu/Desktop/test.s")
			create fd_stream.make
			create formatted_stream.make_raw_ostream (fd_stream)
			create pm.default_create
			create td.make_module (module)
			pm.add (td)
			create verifier.verifier_pass
			pm.add (verifier)
			machine.add_passes_to_emit_file (pm, formatted_stream, 0, 2, True)
			pm.run (module)
			formatted_stream.flush
			io.put_string (fd_stream.string)
--			formatted_stream.dispose
			create assembly_buffer.get_mem_buffer_copy (fd_stream.string)

		end

	assembly_code: STRING =
		"[
; ModuleID = 'test.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.3"

define i32 @main() nounwind ssp {
entry:
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  %1 = call i32 (...)* @rand1() nounwind          ; <i32> [#uses=1]
  store i32 %1, i32* %0, align 4
  %2 = load i32* %0, align 4                      ; <i32> [#uses=1]
  store i32 %2, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @rand1(...)
		]"

end
