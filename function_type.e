note
	description: "Summary description for {FUNCTION_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FUNCTION_TYPE

inherit

	DERIVED_TYPE

create

	make_from_pointer,
	make_with_parameters,
	make_without_parameters

feature {NONE}

	make_with_parameters (return_type: TYPE; parameters: LIST [TYPE])
		local
			parameters_vector: TYPE_VECTOR
		do
			create parameters_vector.make
			across parameters as parameter loop parameters_vector.push_back (parameter.item) end
			item := get_with_parameters_external (return_type.item, parameters_vector.item)
		end

	make_without_parameters (return_type: TYPE)
		do
			item := get_without_parameters_external (return_type.item)
		end

feature

	get_without_parameters_external (return_type: POINTER): POINTER
		external
			"C++ inline use %"llvm/DerivedTypes.h%""
		alias
			"[
				return llvm::FunctionType::get ((const llvm::Type *)$return_type, false);
			]"
		end

	get_with_parameters_external (return_type: POINTER; parameters: POINTER): POINTER
		external
			"C++ inline use %"llvm/DerivedTypes.h%""
		alias
			"[
				return llvm::FunctionType::get (((const llvm::Type *)$return_type), *((const std::vector <const llvm::Type *> *)$parameters), false);
			]"
		end
end
