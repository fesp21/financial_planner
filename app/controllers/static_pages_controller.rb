class StaticPagesController < ApplicationController
	def home
		if signed_in?
			monthCred = Credit.where("extract(month from transaction_date) = ?", Time.now.month).sum(:amount)
			monthDeb = Debit.where("extract(month from transaction_date) = ?", Time.now.month).sum(:amount)
			@empty = true
			if monthCred != 0 and monthDeb != 0
				@total = Money.us_dollar(monthCred - monthDeb)
				@empty = false
			end
		end
	end
end
