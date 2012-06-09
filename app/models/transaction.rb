include MoneyModule

class Transaction < ActiveRecord::Base
	extend MoneyModule
	attr_accessible :amount, :description, :category_id, :transaction_date, :type
	belongs_to :user
	belongs_to :category
	is_money_column :amount

	#validates :amount, presence: true, is_money: true
	validates :transaction_date, presence: true, date: true
	default_scope order: 'transactions.transaction_date DESC, transactions.created_at DESC'
end
