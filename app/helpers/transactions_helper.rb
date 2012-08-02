module TransactionsHelper
	
	# todo: cache cred & deb?
	def transactions_empty?(month)
		return Transaction.where("extract(month from transaction_date) = ?", month).empty?
	end

	def transaction_sum(month)
		monthCred = Credit.where("extract(month from transaction_date) = ?", month).sum(:amount)
		monthDeb = Debit.where("extract(month from transaction_date) = ?", month).sum(:amount)
		return Money.us_dollar(monthCred - monthDeb)
	end
end
