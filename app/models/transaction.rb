include MoneyModule

class Transaction < ActiveRecord::Base
	extend MoneyModule
	attr_accessible :amount, :description, :category_id, :transaction_date
	belongs_to :user
	belongs_to :category
	is_money_column :amount

	validates :amount, presence: true, is_money: true
	validates :transaction_date, presence: true, date: true
	default_scope order: 'transactions.transaction_date DESC, transactions.created_at DESC'

	def self.inherited(child)
		child.instance_eval do
			def model_name
				Transaction.model_name
			end
		end
		super
	end
end
