class DebitsController < ApplicationController
	before_filter :signed_in_user

  def new
  	@debit = Debit.new(transaction_date: Time.now.strftime("%m/%d/%Y"))
  end

  def create
  	@debit = current_user.debits.build(params[:debit])
  	if @debit.save
  		flash.now[:success] = "Debit deducted. *flush*"
  		@debit = Debit.new(transaction_date: Time.now.strftime("%m/%d/%Y"))
  	end
  	render 'new'
  end
end
