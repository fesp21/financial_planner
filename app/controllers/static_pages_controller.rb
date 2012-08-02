class StaticPagesController < ApplicationController
	include TransactionsHelper
	def home
		if signed_in?
			@empty = transactions_empty?(Time.now.month)
			if not @empty
				@total = transaction_sum(Time.now.month)
			end
		end
	end
end
