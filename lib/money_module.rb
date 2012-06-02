module MoneyModule
	def is_number?(num)
		true if Float(num) rescue false
	end
end
