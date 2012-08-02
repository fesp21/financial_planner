class TransactionsController < ApplicationController
	include TransactionsHelper
	before_filter :signed_in_user

	def create
		@type = params[:transaction].delete(:type)
		@transaction = current_user.transactions.build(params[:transaction])
		@transaction.type = @type
		if @transaction.save
			if @type == 'Credit'
				flash[:success] = "Credit added. *cha-ching*"
			elsif @type == 'Debit'
				flash[:success] = "Debit deducted. *flush*"
			end
		end
		redirect_to transactions_path
	end

	def destroy
		Transaction.find(params[:id]).destroy
		flash[:success] = "You can pretend like it didn't happen, but we all know it did."
		redirect_to transactions_path
	end

	def index
		@transactions = Transaction.paginate(:page => params[:page])
		@debit = Debit.new(transaction_date: Time.now.to_date)
		@credit = Credit.new(transaction_date: Time.now.to_date)
	end

	# todo: by years
	def months
		earliest = Transaction.minimum(:transaction_date).month
		@months = {}
		Time.now.month.downto(earliest).each do |month|
			@months[Date::MONTHNAMES[month]] = transaction_sum(month)
		end
	end
end
