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
			fd_stream: RAW_FD_OSTREAM
			formatted_stream: FORMATTED_RAW_OSTREAM
			pm: PASS_MANAGER
			td: TARGET_DATA
			verifier: FUNCTION_PASS
			triple_string: STRING
		do
			tr.initialize_all_targets
			tr.initialize_all_asm_printers
			create buff.get_file ("/Users/clemahieu/Desktop/hello.s")
			create diag
			create context
			create module.parse_assembly (buff, diag, context)
			triple_string := module.get_target_triple
			target := tr.lookup_target (triple_string)
			machine := target.create_target_machine (triple_string, "")
			create fd_stream.make_filename ("/Users/clemahieu/Desktop/hello.asm")
			create formatted_stream.make_raw_ostream (fd_stream)
			create pm.default_create
			create td.make_module (module)
			pm.add (td)
			create verifier.verifier_pass
			pm.add (verifier)
			machine.add_passes_to_emit_file (pm, formatted_stream, 1, 2, True)
			pm.run (module)
			formatted_stream.dispose
		end

end
