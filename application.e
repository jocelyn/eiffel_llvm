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
		do
			tr.initialize_all_targets
			target := tr.lookup_target ("i686-apple-darwin9")
			machine := target.create_target_machine ("i686-apple-darwin9", "")
			create fd_stream.make_filename ("/Users/colinlemahieu/Desktop/test2.o.S")
			create formatted_stream.make_raw_ostream (fd_stream)
			create diag
			create context
			create buff.get_file ("/Users/colinlemahieu/Desktop/test.o.ll")
			buff_size := buff.get_buffer_size
			create module.parse_assembly (buff, diag, context)
			create pm.default_create
			create td.make_module (module)
			pm.add (td)
			create verifier.verifier_pass
			pm.add (verifier)
			machine.add_passes_to_emit_file (pm, formatted_stream, 0, 2, False)
			pm.run (module)
		end

	dump
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%", %"stdio.h%""
		alias
			"[
				llvm::TargetRegistry::iterator i;
				
				for (i = llvm::TargetRegistry::begin (); i == llvm::TargetRegistry::end (); i++)
				{
					printf ("%s\n", i->getName ());
				}
			]"
		end

end
