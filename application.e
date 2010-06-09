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
		do
			tr.initialize_all_targets
			target := tr.lookup_target ("i686-apple-darwin9")
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
