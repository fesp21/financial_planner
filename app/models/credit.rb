# == Schema Information
#
# Table name: credits
#
#  id               :integer         not null, primary key
#  amount           :integer         not null
#  transaction_date :date            not null
#  description      :text
#  user_id          :integer         not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

include MoneyModule

class Credit < ActiveRecord::Base
	extend MoneyModule
	attr_accessible :amount, :description, :transaction_date
	belongs_to :user
	is_money_column :amount

	validates :amount, presence: true, is_money: true
	validates :transaction_date, presence: true, date: true
	default_scope order: 'credits.transaction_date DESC, credits.created_at DESC'
end
