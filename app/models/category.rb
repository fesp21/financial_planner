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
	attr_accessible :name, :budget
	composed_of :budget,
							:class_name => 'Money',
							:mapping => %w(budget cents),
							:constructor => Proc.new { |cents| Money.new(cents || 0, Money.default_currency) },
							:converter => Proc.new { |value|
								if value.respond_to?(:to_money)
									money = value.to_money
									money.original_value = value
									money
								else 
									raise(ArgumentError, "Can't convert #{value.class} to Money") 
								end
							}

	validates :name, presence: true, uniqueness: true
	validates :budget, presence: true, is_money: true
end
