# == Schema Information
#
# Table name: goals
#
#  id         :integer         not null, primary key
#  name       :string(50)      not null
#  cost       :integer         not null
#  rank       :integer         not null
#  purchased  :boolean         not null
#  user_id    :integer         not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

include MoneyModule

class Goal < ActiveRecord::Base
	extend MoneyModule
	attr_accessible :name, :cost, :rank, :purchased
	is_money_column :cost
	belongs_to :user

	# todo: eventually, the unique columns should only be unique by user group
	validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
	validates :cost, presence: true, is_money: true
	# todo: cascade rank on uniqueness violation
	validates :rank, presence: true, uniqueness: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
	validates_inclusion_of :purchased, in: [true, false], message: "must be true or false"
	default_scope order: 'goals.rank'
end
