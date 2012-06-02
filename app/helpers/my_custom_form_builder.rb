class MyCustomFormBuilder < ActionView::Helpers::FormBuilder
	def money_field(method, options = {})
		value = @object.send(method)
		formatted_value = value.original_value || value.format(symbol: false)
		text_field method, options.merge(:value => (formatted_value))
	end
end
