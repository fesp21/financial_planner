# == Schema Information
#
# Table name: transactions
#
#  id               :integer         not null, primary key
#  amount           :integer         not null
#  description      :text
#  category_id      :integer
#  transaction_date :date            not null
#  user_id          :integer         not null
#  type             :string(20)      not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

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
