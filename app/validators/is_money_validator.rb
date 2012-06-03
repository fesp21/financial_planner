class IsMoneyValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		_, cents = value.original_value.to_s.gsub(/[^0-9.]/, '').split(".")
		if value.original_value.blank?
			msg = "can't be blank"
		elsif is_number?(value.original_value)	
			if cents && (cents.length > 2)
				msg = "can't have fractions of a cent"
			elsif value.cents <= 0
				 msg = "can't be negative or zero"
			end
		else
			msg = "is not a number"
		end

		if msg
			record.errors[attribute] << (options[:message] || msg)
		end
	end
end
