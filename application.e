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
		do
			tr.initialize_all_targets
			target := tr.lookup_target ("i686-apple-darwin9")
			machine := target.create_target_machine ("i686-apple-darwin9", "")
			create diag
			create context
			create buff.get_file ("/Users/colinlemahieu/Desktop/test.o.ll")
			buff_size := buff.get_buffer_size
			create module.parse_assembly (buff, diag, context)
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
