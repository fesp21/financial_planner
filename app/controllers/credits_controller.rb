class CreditsController < ApplicationController
	before_filter :signed_in_user

	def new
		@credit = Credit.new(transaction_date: Time.now.strftime("%m/%d/%Y"))
	end

	def create
		@credit = current_user.credits.build(params[:credit])
		if @credit.save
			flash[:success] = "Credit added. *cha-ching*"
			redirect_to new_credit_path
		else
			render 'new'
		end
	end
end
