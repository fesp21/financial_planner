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

# todo: validations (empty & fractional cents should not be allowed)

class Category < ActiveRecord::Base
	attr_accessible :name, :budget
	composed_of :budget, 
							:class_name => 'Money',
							:mapping => %w(budget cents),
							:constructor => Proc.new { |cents| Money.new(cents, Money.default_currency) },
							:converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

	validates :name, presence: true, uniqueness: true
	validates :budget, presence: true, numericality: true
end
