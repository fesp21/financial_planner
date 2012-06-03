include MoneyModule

class Debit < ActiveRecord::Base
	extend MoneyModule
	attr_accessible :cost, :description, :category_id, :transaction_date
	belongs_to :category
	belongs_to :user
	is_money_column :cost

	validates :cost, presence: true, is_money: true
	validates :transaction_date, date: true
end
