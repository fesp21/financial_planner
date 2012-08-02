class StaticPagesController < ApplicationController
	def home
		if signed_in?
			monthCred = Credit.where("extract(month from transaction_date) = ?", Time.now.month).sum(:amount)
			monthDeb = Debit.where("extract(month from transaction_date) = ?", Time.now.month).sum(:amount)
			@total = Money.us_dollar(monthCred - monthDeb)
		end
	end
end
