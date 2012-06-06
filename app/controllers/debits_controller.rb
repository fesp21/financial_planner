class DebitsController < ApplicationController
	before_filter :signed_in_user

	def new
		@debit = Debit.new(transaction_date: Time.now.strftime("%m/%d/%Y"))
	end

	def create
		@debit = current_user.debits.build(params[:debit])
		if @debit.save
			flash[:success] = "Debit deducted. *flush*"
			redirect_to new_debit_path
		else
			render 'new'
		end
	end

	def destroy
		Debit.find(params[:id]).destroy
		flash[:success] = "You can pretend like it didn't happen, but we all know it did."
		redirect_to debits_path
	end

	def index
		@debits = Debit.paginate(:page => params[:page])
	end
end
