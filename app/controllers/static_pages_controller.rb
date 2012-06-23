class StaticPagesController < ApplicationController
	def home
		@total = Money.us_dollar(Credit.sum(:amount) - Debit.sum(:amount))
	end
end
