module MoneyModule
	def is_number?(num)
		true if Float(num) rescue false
	end

	def is_money_column(column)
		composed_of column,
								:class_name => 'Money',
								:mapping => [column, "cents"],
								:constructor => Proc.new { |cents|
									num = cents.nil? ? 0 : Float(cents)
									Money.new(num || 0, Money.default_currency) 
								},
								:converter => Proc.new { |value|
									if value.respond_to?(:to_money)
										money = value.to_money
										money.original_value = value
										money
									else 
										raise(ArgumentError, "Can't convert #{value.class} to Money") 
									end
								}
	end
end
