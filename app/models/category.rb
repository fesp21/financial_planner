# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  budget     :integer         not null
#  name       :string(50)      not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

include MoneyModule

class Category < ActiveRecord::Base
	extend MoneyModule
	attr_accessible :name, :budget
	is_money_column :budget
	has_many :debits

	# todo: eventually, the unique columns should only be unique by user group
	validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
	validates :budget, presence: true, is_money: true
end
