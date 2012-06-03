# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  budget     :integer         not null
#  name       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

include MoneyModule

class Category < ActiveRecord::Base
	extend MoneyModule
	attr_accessible :name, :budget
	is_money_column :budget

	validates :name, presence: true, uniqueness: true
	validates :budget, presence: true, is_money: true
end
