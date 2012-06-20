class MyCustomFormBuilder < BootstrapForms::FormBuilder
	def money_field(method, options = {})
		value = @object.send(method)
		if value.original_value
			formatted_value = value.original_value
		elsif value.cents == 0
			formatted_value = ""
		else
			formatted_value = value.format(symbol: false)
		end
		number_field method, options.merge(prepend: '$', value: (formatted_value), min: 0.01, step: 0.01)
	end
end
