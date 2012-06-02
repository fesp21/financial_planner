class MyCustomFormBuilder < ActionView::Helpers::FormBuilder
	def money_field(method, options = {})
		value = @object.send(method)
		if value.original_value
			formatted_value = value.original_value
		elsif value.cents == 0
			formatted_value = ""
		else
			formatted_value = value.format(symbol: false)
		end
		text_field method, options.merge(:value => (formatted_value))
	end
end
