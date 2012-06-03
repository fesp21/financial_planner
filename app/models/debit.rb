# == Schema Information
#
# Table name: debits
#
#  id               :integer         not null, primary key
#  cost             :integer         not null
#  description      :text
#  category_id      :integer
#  transaction_date :date
#  user_id          :integer         not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

include MoneyModule

class Debit < ActiveRecord::Base
	extend MoneyModule
	attr_accessible :cost, :description, :category_id, :transaction_date
	belongs_to :category
	belongs_to :user
	is_money_column :cost

	validates :cost, presence: true, is_money: true
	validates :transaction_date, date: true
	default_scope order: 'debits.transaction_date DESC'
end
